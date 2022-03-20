//
//  FeatureSectionViewCell.swift
//  MyAppstore
//
//  Created by 유한석 on 2022/03/20.
//

import SnapKit
import UIKit
import Then


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
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    func setupCell(){
        [typeLabel, appNameLabel, descriptionLabel, imageView].forEach { make in
            addSubview(make)
        }
        typeLabel.text = "새로운 경험"
        appNameLabel.text = "Game Friends"
        descriptionLabel.text = "을기을긱릭르이"

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
            make.leading.trailing.equalTo(typeLabel.snp.leading)
            make.top.equalTo(appNameLabel.snp.bottom).offset(4)
        }
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(typeLabel.snp.leading)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(8.0)
        }
    }
}
