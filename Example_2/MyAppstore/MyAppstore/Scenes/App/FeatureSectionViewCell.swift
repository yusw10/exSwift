//
//  FeatureSectionViewCell.swift
//  MyAppstore
//
//  Created by 유한석 on 2022/03/20.
//

import SnapKit
import UIKit
import Then
import Kingfisher

final class FeatureSectionViewCell: UICollectionViewCell{
    private var typeLabel = UILabel().then{ make in
        make.font = .systemFont(ofSize: 12.0, weight: .semibold)
        make.textColor = .systemBlue
    }
//    private lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 12.0, weight: .semibold)
//        label.textColor = .systemBlue
//
//        return label
//    }()
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = UIColor.label
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        label.textColor = UIColor.secondaryLabel
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 7.0
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.separator.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBlue
        return imageView
    }()
    
    
    func setupCell(feature: Feature){
        [typeLabel, appNameLabel, descriptionLabel, imageView].forEach { make in
            addSubview(make)
        }
        typeLabel.text = feature.type
        appNameLabel.text = feature.appName
        descriptionLabel.text = feature.description
        
        
        typeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        appNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(typeLabel.snp.leading)
            make.top.equalTo(typeLabel.snp.bottom)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(typeLabel.snp.leading)
            make.top.equalTo(appNameLabel.snp.bottom).offset(4)
        }
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(typeLabel.snp.leading)
            make.trailing.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(16.0)
        }
        
        //kingfisher
        if let imageURL = URL(string: feature.imageURL){
            imageView.kf.setImage(
                with: imageURL
            )
        }
    }
}
