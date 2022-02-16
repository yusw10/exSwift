//
//  Alert.swift
//  Drink
//
//  Created by 유한석 on 2022/02/16.
//

import Foundation

struct Alert: Codable{
    var id: String = UUID().uuidString
    let date: Date
    var isOn: Bool
    
    var time: String{
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm"
        return timeFormatter.string(from: date)
    }
    
    var meridiem: String{
        let meridiemFormatter = DateFormatter()
        meridiemFormatter.dateFormat = "a" // 오전오후를 표현하는 포매터 값
        meridiemFormatter.locale = Locale(identifier: "ko") // setting nation 
        return meridiemFormatter.string(from: date)
    }
}
