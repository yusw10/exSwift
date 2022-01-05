//
//  ViewController.swift
//  COVID19
//
//  Created by 유한석 on 2022/01/04.
//
import Charts
import UIKit
import Alamofire
class ViewController: UIViewController {
    @IBOutlet weak var pieChartView: PieChartView!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var labelStackView: UIStackView!
    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var newCaseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicatorView.startAnimating()
        self.fetchCovidOverview(completionHandler: { [weak self] result in
            guard let self = self else { return }
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden = true
            self.labelStackView.isHidden = false
            self.pieChartView.isHidden = false
            
            switch result {
            case let .success(result):
                let covidOverView = self.makeCovideOverviewList(cityCovidOverview: result)
                self.configureCharView(covideOverViewList: covidOverView)
                self.configureStackView(koreaCovidOverview: result.korea)
            case let .failure(error):
                debugPrint("error \(error)")
            }
        
        })
        
    }
    func makeCovideOverviewList( cityCovidOverview: CityCovidOverView) -> [CovidOverview]{
        return [
            cityCovidOverview.seoul,
            cityCovidOverview.busan,
            cityCovidOverview.daegu,
            cityCovidOverview.incheon,
            cityCovidOverview.gwangju,
            cityCovidOverview.daejeon,
            cityCovidOverview.ulsan,
            cityCovidOverview.sejong,
            cityCovidOverview.gyeonggi,
            cityCovidOverview.chungbuk,
            cityCovidOverview.chungnam,
            cityCovidOverview.gyeongbuk,
            cityCovidOverview.gyeongnam,
            cityCovidOverview.jeju
        ]
    }
    
    func configureCharView(covideOverViewList:[CovidOverview]){
        self.pieChartView.delegate = self
        let entries = covideOverViewList.compactMap { [weak self] overview -> PieChartDataEntry? in
            guard let self = self else { return  nil }
            return PieChartDataEntry(
                value: self.removeFormatString(string: overview.newCase),
                label: overview.countryName,
                data: overview
            )
        }
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
        dataSet.sliceSpace = 1
        dataSet.entryLabelColor = .black
        dataSet.xValuePosition = .outsideSlice
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.3
        dataSet.valueTextColor = .black
        
        dataSet.colors = ChartColorTemplates.vordiplom() + ChartColorTemplates.joyful() + ChartColorTemplates.liberty() + ChartColorTemplates.pastel() + ChartColorTemplates.material()
        self.pieChartView.data = PieChartData(dataSet: dataSet)
        self.pieChartView.spin(duration: 0.3, fromAngle: self.pieChartView.rotationAngle, toAngle: self.pieChartView.rotationAngle + 80)
    }
    
    func removeFormatString(string: String) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: string)?.doubleValue ?? 0
    }
    func configureStackView(koreaCovidOverview: CovidOverview){
        self.totalCaseLabel.text = "\(koreaCovidOverview.totalCase) 명"
        self.newCaseLabel.text = "\(koreaCovidOverview.newCase) 명"
    }
    
    func fetchCovidOverview(
        completionHandler: @escaping (Result<CityCovidOverView, Error>) -> Void
    ){
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey": "q8C42xmcIEwkdNujvbKeWUnVTXz9f5GBZ"
        ]
        AF.request(url, method: .get, parameters: param).responseData(completionHandler: { response in
            switch response.result{
            case let .success(data):
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(CityCovidOverView.self, from: data)
                    completionHandler(.success(result))
                }catch{
                    completionHandler(.failure(error))
                }
            case let .failure(error):
                completionHandler(.failure(error))
            }
        })
    }
    
    

}



extension ViewController: ChartViewDelegate{
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let covidDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "CovidDetailViewController") as? CovidDetialViewController else { return }
        guard let covidOverview = entry.data as? CovidOverview else { return }
        covidDetailViewController.covidOverview = covidOverview
        self.navigationController?.pushViewController(covidDetailViewController, animated: true)
    }
}
