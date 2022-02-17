//
//  UNNotificationCenter.swift
//  Drink
//
//  Created by 유한석 on 2022/02/17.
//

import Foundation
import UserNotifications

extension UNUserNotificationCenter{
    func addNotificationRequest(by alert: Alert){
        //1. 알림의 내용이될 컨텐츠 생성
        let content = UNMutableNotificationContent()
        content.title = "물 마실 시간이에오"
        content.body = "근손실이 오지 않으려면 2리터를 마셔야헤오"
        content.sound = .default
        content.badge = 1
        let component = Calendar.current.dateComponents([.hour, .minute], from: alert.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: alert.isOn)
        
        let request = UNNotificationRequest(identifier: alert.id, content: content, trigger: trigger)
        
        self.add(request, withCompletionHandler: nil)
        
    }
}
