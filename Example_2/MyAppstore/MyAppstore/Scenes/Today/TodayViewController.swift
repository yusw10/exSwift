//
//  TodayViewController.swift
//  MyAppstore
//
//  Created by 유한석 on 2022/03/15.
//

import UIKit
import SnapKit // autolayout framework
import Foundation

//가장 최상위 뷰컨이라 final
final class TodayViewController: UIViewController {
    private var todayList: [Today] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: "todayCell")
        collectionView.register(
            TodayCollectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "TodayCollectionHeaderView"
        )
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        fetchData()
        print("@@@TODAY LIST COUNT : \(todayList.count)")
    }
}


extension TodayViewController: UICollectionViewDataSource{
    //몇개가 보여질건지
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayList.count
    }
    //무슨 셀 타입을 반환?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todayCell", for: indexPath) as? TodayCollectionViewCell
        let today = todayList[indexPath.item]
        cell?.setup(today: today)
        return cell ?? UICollectionViewCell()
    }
    
    //header와 footer가 이 리유저블뷰를 공유해서 사용하기 때문에 만약에 두개라면 이를 구분해주어야 한다.
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "TodayCollectionHeaderView",
                for: indexPath
              ) as? TodayCollectionHeaderView
        else { return UICollectionReusableView() }
        
        header.setupViews()
        
        return header
    }
}

extension TodayViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32 // 셀의 leading trailing 이 각각 16
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width - 32, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let value : CGFloat = 16.0
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let today = todayList[indexPath.item]
        let vc = AppDetailViewController(today:today)
        present(vc, animated: true, completion: nil)
    }
}

private extension TodayViewController {
    func fetchData() {
        guard let url = Bundle.main.url(forResource: "Today", withExtension: "plist") else {
            print("url metching fail")
            return
        }

      
        do {
            let data = try Data(contentsOf: url)
            print("data: \(data.count)")
            let result = try PropertyListDecoder().decode([Today].self, from: data)
            todayList = result
            print("completion Today list fetching")
        } catch {}
    }
}
