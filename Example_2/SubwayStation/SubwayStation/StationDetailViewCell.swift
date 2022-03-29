//
//  StationDetailViewCell.swift
//  SubwayStation
//
//  Created by 유한석 on 2022/03/29.
//

import Foundation
import UIKit
import SnapKit
import Then

class StationDetailViewCell: UICollectionViewCell{
    private var titleLabel = UILabel().then { UILabel in
        UILabel.font = .systemFont(ofSize: 14, weight: .bold)
    }
    private var subTitleLabel = UILabel().then { UILabel in
        UILabel.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    
    func setupCellContent(stationDetail: StationDetail){
        titleLabel.text = stationDetail.title
        subTitleLabel.text = stationDetail.subTitle
    }
    func setupCellLayout(){
        [titleLabel, subTitleLabel].forEach { UILabel in
            addSubview(UILabel)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
    }
}
