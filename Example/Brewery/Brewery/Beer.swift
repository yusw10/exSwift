//
//  Beer.swift
//  Brewery
//
//  Created by 유한석 on 2022/03/01.
//

import Foundation

struct Beer: Decodable{
    let id: Int?
    let name,taglineString, description, brewersTips, imageURL: String?
    let foodPairing: [String]?
    
    var tagline: String{
        let tags = taglineString?.components(separatedBy: ". ")
        let hasgtags = tags?.map{
            "#" + $0.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: " #")
        }
        return hasgtags?.joined(separator: " ") ?? ""
    }
    enum CodingKeys: String, CodingKey {
        case id , name, description
        case taglineString = "tagline"
        case imageURL =  "image_url"
        case brewersTips =  "brewers_tips"
        case foodPairing = "food_pairing"
    }
}
