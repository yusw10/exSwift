//
//  ContentCollectionViewHeader.swift
//  NetflixStyleSampleApp
//
//  Created by 유한석 on 2022/02/23.
//

import UIKit
//반드시 리유저블 뷰를 상속받아야 footer나 header로 사용이 가능하다.
class ContentCollectionViewHeader: UICollectionReusableView{
    let sectionsNameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionsNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionsNameLabel.textColor = .white
        sectionsNameLabel.sizeToFit()
        
        addSubview(sectionsNameLabel)
        
        sectionsNameLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.top.bottom.leading.equalToSuperview().offset(10)
        }
    }
}
