//
//  TodayCollectionViewCell.swift
//  MyAppstore
//
//  Created by 유한석 on 2022/03/16.
//

import SnapKit
import UIKit

final class TodayCollectionViewCell: UICollectionViewCell{
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true // 이미지가 이미지뷰의 크기보다 크면 벗어나서 표시되는걸 방지하는 프로퍼티
        imageView.layer.cornerRadius = 12.0
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    func setup(){
        setupSubViews()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        subTitleLabel.text = "서브타이틀"
        descriptionLabel.text = "설명설명"
        titleLabel.text = "메인 타이틀"
    }
}

private extension TodayCollectionViewCell{
    func setupSubViews(){
        [imageView, titleLabel,subTitleLabel, descriptionLabel]
            .forEach { UIView in
                addSubview(UIView)
            }
        subTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(24.0)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24.0)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(4.0)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(24.0)
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
