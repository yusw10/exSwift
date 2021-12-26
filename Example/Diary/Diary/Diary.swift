//
//  Diary.swift
//  Diary
//
//  Created by 유한석 on 2021/12/19.
//

import Foundation

struct Diary{
    var title: String
    var contents: String
    var date: Date
    var isStar: Bool
    func selfDebug(){
        debugPrint("asdasdasd")
        debugPrint("title=> \(self.title)")
        debugPrint("contents=> \(self.contents)")
        debugPrint("date=> \(self.date.description)")
        debugPrint("isStar=> \(self.isStar)")
    }
}
