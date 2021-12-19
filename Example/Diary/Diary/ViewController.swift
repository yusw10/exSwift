//
//  ViewController.swift
//  Diary
//
//  Created by 유한석 on 2021/12/15.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    private var diaryList = [Diary](){
        didSet{
            self.saveDiaryList()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let writeDiaryViewController = segue.destination as? WriteDiaryViewController{
            writeDiaryViewController.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        // Do any additional setup after loading the view.
    }
    
    private func dateToString(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    private func configureCollectionView(){
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func saveDiaryList(){
        let date = self.diaryList.map{
            [
                "title":$0.title,
                "contents":$0.contents,
                "date":$0.date,
                "isStar":$0.isStar
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(date, forKey: "diaryList")
    }
    
    private func loadDiaryList(){
        let userDefaults = UserDefaults.standard
        guard let data =  userDefaults.object(forKey: "diaryList") as? [[String:Any]] else{return}
        self.diaryList = data.compactMap(
            guard let title = $0["title"] as? String else{return}
            guard let title = $0["title"] as? String else{return}
            guard let title = $0["title"] as? String else{return}
            guard let title = $0["title"] as? String else{return}
        )
    }
}

extension ViewController: WriteDiaryViewDelegate{
    func didSelectRegister(diary: Diary) {
        self.diaryList.append(diary)
        self.collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else{ return UICollectionViewCell()}
        let diary = self.diaryList[indexPath.row]
        cell.titleLabel.text = diary.title
        cell.dateLabel.text = self.dateToString(date: diary.date)
        return cell
    }
}

extension ViewController:UICollectionViewDelegateFlowLayout{
    //셀의 사이즈를 지정해준다
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //각 엣지 여백을 위에서 10이라고 했으니까 합 20을 빼준다.
        return CGSize(width: (UIScreen.main.bounds.width/2) - 20, height: 200)
        
    }
    
}
