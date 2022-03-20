//
//  RankingFeatureSectionViewCell.swift
//  MyAppstore
//
//  Created by 유한석 on 2022/03/20.
//

import SnapKit
import Then
import UIKit

final class RankingFeatureSectionViewCell: UICollectionViewCell{
    static var height: CGFloat = 70.0
    
    private var imageView = UIImageView().then{ make in
        make.layer.cornerRadius = 7.0
        make.layer.borderWidth = 0.5
        make.layer.borderColor = UIColor.separator.cgColor
        make.backgroundColor = .tertiarySystemGroupedBackground
    }
    private var titleLabel = UILabel().then{ make in
        make.font = .systemFont(ofSize: 16.0, weight: .bold)
        make.numberOfLines = 2
        make.textColor = .label
    }
    private var descriptionLabel = UILabel().then{ make in
        make.font = .systemFont(ofSize: 13.0, weight: .semibold)
        make.textColor = UIColor.secondaryLabel
    }
    private var downloadButton = UIButton().then{ make in
        make.setTitle("받기", for: .normal)
        make.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        make.setTitleColor(.systemBlue, for: .normal)
        make.backgroundColor = .secondarySystemBackground
        make.layer.cornerRadius = 12.0
    }
    private var inAppPurchaseInfoLabel = UILabel().then{ make in
        make.font = .systemFont(ofSize: 10.0, weight: .semibold)
        make.text = "앱 내 구입"
    }
    
    func setup(){
        setupCell()
        titleLabel.text = "테스트 타이틀"
        descriptionLabel.text = "테스트 디스크립션"
        inAppPurchaseInfoLabel.isHidden = false
    }
}


private extension RankingFeatureSectionViewCell{
    func setupCell(){
        [imageView, titleLabel, descriptionLabel, downloadButton, inAppPurchaseInfoLabel].forEach { UIView in
            addSubview(UIView)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.0)
            make.bottom.top.equalToSuperview().inset(4.0)
            make.width.equalTo(imageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(8.0)
            make.top.equalToSuperview().inset(8.0)
            make.trailing.equalTo(downloadButton.snp.leading)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(downloadButton.snp.leading)
        }
        downloadButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(50.0)
            make.height.equalTo(24)
            make.trailing.equalToSuperview().inset(16.0)
        }
        inAppPurchaseInfoLabel.snp.makeConstraints { make in
            make.centerX.equalTo(downloadButton.snp.centerX)
            make.top.equalTo(downloadButton.snp.bottom).offset(4.0)
        }
    }
}
