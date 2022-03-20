//
//  TabBarController.swift
//  MyAppstore
//
//  Created by 유한석 on 2022/03/15.
//

import UIKit

class TabBarController: UITabBarController {
    
    //탭바에서는 두개의 컴포넌트가 필요하다
    
    private lazy var todayViewController: UIViewController = {
        let viewController = TodayViewController()
        //탭바에 대한 정보 구성
        let uiTabBatItem = UITabBarItem(
            title: "투데이",
            image: UIImage(systemName: "mail"),
            tag: 0
        )
        viewController.tabBarItem = uiTabBatItem
        return viewController
    }()
    private lazy var appViewController: UIViewController = {
        
        let viewController = UINavigationController(rootViewController: AppViewController())
        //탭바에 대한 정보 구성
        let uiTabBatItem = UITabBarItem(
            title: "앱",
            image: UIImage(systemName: "square.stack.3d.up"),
            tag: 1
        )
        viewController.tabBarItem = uiTabBatItem
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewControllers = [todayViewController, appViewController]
    }
}

