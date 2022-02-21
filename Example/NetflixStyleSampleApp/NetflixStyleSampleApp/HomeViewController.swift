//
//  HomeViewController.swift
//  NetflixStyleSampleApp
//
//  Created by 유한석 on 2022/02/21.
//

import UIKit

class HomeViewController: UICollectionViewController{
    var contents: [Content] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true // 스크롤로 해서 스와이프하면 안보이게 하는 옵션
        //UIImage(named: "netflix_icon")
        
        let image : UIImage = #imageLiteral(resourceName: "netflix_icon")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image , style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
        
        //Data Setting
        contents = getContent()
    }
    
    
    func getContent() -> [Content]{
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let list = try? PropertyListDecoder().decode([Content].self, from: data) else { return [] }
        return list
    }
}

//UICollectionView data delegate and datasource
extension HomeViewController{
    //섹션당 보여줄 셀의 개수 설정
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        default:
            return contents[section].contentItem.count
        }
    }
    //콜렉션 뷰 셀 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    //전체 섹션 개수 설정[몇줄인지]
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
    }
    //셀 선택시 동장
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = contents[indexPath.section].sectionName
        print("Test: \(sectionName)섹션의 \(indexPath.row+1)번째 컨텐츠 클릭")
    }
}

