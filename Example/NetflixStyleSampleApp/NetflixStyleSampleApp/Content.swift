//
//  Content.swift
//  NetflixStyleSampleApp
//
//  Created by 유한석 on 2022/02/21.
//

import UIKit

struct Content: Decodable{
    let sectionType: SectionType
    let sectionName: String
    let contentItem: [Item]
    
    enum SectionType: String , Decodable{
        case basic
        case main
        case rank
        case large
    }
}

struct Item: Decodable{
    let description: String
    let imageName: String
    
    var image: UIImage{
        return UIImage(named: imageName) ?? UIImage()
    }
}

