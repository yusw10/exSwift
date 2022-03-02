//
//  BeerListCell.swift
//  Brewery
//
//  Created by 유한석 on 2022/03/01.
//

import UIKit
import SnapKit
import Kingfisher

class BeerListCell: UITableViewCell{
    let beerImageView = UIImageView()
    let nameLabel = UILabel()
    let taglineLablel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [beerImageView, nameLabel, taglineLablel].forEach{
            contentView.addSubview($0)
        }
        beerImageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        nameLabel.numberOfLines = 2
        
        taglineLablel.font = .systemFont(ofSize: 14, weight: .light)
        taglineLablel.textColor = .systemBlue
        taglineLablel.numberOfLines = 0
        
        beerImageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.top.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(120)
        }
        
        nameLabel.snp.makeConstraints{
            $0.leading.equalTo(beerImageView.snp.trailing).offset(10)
            $0.bottom.equalTo(beerImageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        taglineLablel.snp.makeConstraints{
            $0.leading.trailing.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
    }
    
    func configure(with beer: Beer){
        let imageURL = URL(string: beer.imageURL ?? "")
        let defaultImage = #imageLiteral(resourceName: "Beer")
        beerImageView.kf.setImage(with: imageURL, placeholder: defaultImage)
        
        nameLabel.text = beer.name ?? "이름 없는 맥주"
        
        taglineLablel.text = beer.tagline
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none // 탭해도 회색음영 x
    }
    
}
