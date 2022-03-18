//
//  TodayCollectionHeaderView.swift
//  MyAppstore
//
//  Created by 유한석 on 2022/03/16.
//

import UIKit
import SnapKit

final class TodayCollectionHeaderView: UICollectionReusableView{
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "6월 28일 월요일"
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "투데이"
        label.font = .systemFont(ofSize: 36.0, weight: .black)
        return label
    }()
    
    func setupViews(){
        [dateLabel,titleLabel].forEach { UILabel in
            addSubview(UILabel)
        }
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.0)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(32)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
        }
    }
    
    
}
