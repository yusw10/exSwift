//
//  ContentCollectioinViewCell.swift
//  NetflixStyleSampleApp
//
//  Created by 유한석 on 2022/02/22.
//

import Foundation
import SnapKit
import UIKit

class ContentCollectionViewCell: UICollectionViewCell{
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        
        
    }
}
