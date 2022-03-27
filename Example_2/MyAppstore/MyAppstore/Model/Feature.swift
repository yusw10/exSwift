//
//  Feature.swift
//  MyAppstore
//
//  Created by 유한석 on 2022/03/21.
//

import Foundation

struct Feature: Decodable{
    let type: String
    let appName: String
    let description: String
    let imageURL: String
}
