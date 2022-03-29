//
//  StationDetailViewController.swift
//  SubwayStation
//
//  Created by 유한석 on 2022/03/29.
//

import SnapKit
import UIKit

class StationDetailViewController: UICollectionView{
    private var collectionView : UICollectionView = {
        let collectionView = UICollectionView()
        let layout = UICollectionViewLayout()
        collectionView.layout = layout
    }()
}

extension StationDetailViewController: UICollectionViewDataSource{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StationDetailViewCell", for: indexPath) as? StationDetailViewCell else { return UICollectionViewCell()}
        cell?.setupCellLayout()
        cell?.setupCellContent(stationDetail: StationDetail())
    }
}
