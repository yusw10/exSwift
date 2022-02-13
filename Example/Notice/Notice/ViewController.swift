//
//  ViewController.swift
//  Notice
//
//  Created by 유한석 on 2022/02/09.
//

import UIKit
import FirebaseRemoteConfig
import FirebaseAnalytics

class ViewController: UIViewController {
    var remoteConfig : RemoteConfig?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remoteConfig = RemoteConfig.remoteConfig()
        
        let setting = RemoteConfigSettings()
        setting.minimumFetchInterval = 0
        remoteConfig?.configSettings = setting
        remoteConfig?.setDefaults(fromPlist: "RemotConfigDefaults")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNotice()
    }
}


extension ViewController{
    func getNotice(){
        guard let remoteConfig = remoteConfig else { return }
        remoteConfig.fetch{ [weak self] status, _ in
            if status == .success{
                remoteConfig.activate(completion: nil)
            }else{
                print("ERROR FETCHING FIREBASE")
            }
            guard let self = self  else {
                return
            }
            if !self.isNoticeHidden(remoteConfig){
                let noticeVC = NoticeViewController(nibName: "NoticeViewController", bundle: nil)
                noticeVC.modalPresentationStyle = .custom
                noticeVC.modalTransitionStyle = .crossDissolve
                
                let title = (remoteConfig["title"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                let detail = (remoteConfig["detail"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                let date = (remoteConfig["date"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                
                noticeVC.noticeContents = (title: title, detail:detail, date: date)
                self.present(noticeVC, animated: true, completion: nil)
            }else{
                self.showEventAlert()
            }
        }
    }
    func isNoticeHidden(_ remoteConfig: RemoteConfig) -> Bool{
        return remoteConfig["isHidden"].boolValue
    }
}
// A/B testing
extension ViewController{
    func showEventAlert(){
        guard let remoteConfig = remoteConfig else{
            return
        }
        remoteConfig.fetch{ [weak self] status, _ in
            if status == .success {
                remoteConfig.activate(completion: nil)
            }else{
                print("config not fetched")
            }
            let message = remoteConfig["message"].stringValue ?? ""
            let confirmAction = UIAlertAction(title: "확인하기", style: .default) { _ in
                Analytics.logEvent("promotion_alert", parameters: nil)
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            let alertController = UIAlertController(title: "깜짝이벤트", message: message, preferredStyle: .alert)
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}
