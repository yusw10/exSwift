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
    
    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var newCaseLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchCovidOverview(completionHandler: { [weak self] result , asdasd in
            guard let self = self else { return }
            switch result {
            case let .success(result):
                self.newCaseLabel.text = "asdasd"
                debugPrint("success \(result)")
            case let .failure(error):
                debugPrint("error \(error)")
            }
        
        })
        DispatchQueue.main.async { [weak self] in
            self?.totalCaseLabel.text = "123123"
        }
        
    }
    
   
    
    
    func fetchCovidOverview(
        completionHandler: @escaping (Result<CityCovidOverView, Error> , Bool) -> Void
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
                    completionHandler(.success(result) , false)
                }catch{
                    completionHandler(.failure(error) , false)
                }
            case let .failure(error):
                completionHandler(.failure(error) , false)
            }
        })
    }
    
    

}



