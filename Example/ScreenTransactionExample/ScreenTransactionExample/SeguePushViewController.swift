//
//  suguePushViewController.swift
//  ScreenTransactionExample
//
//  Created by 유한석 on 2021/12/03.
//

import UIKit

class SeguePushViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    
    override func viewDidLoad() {
        print("asdasdasdasd")

        super.viewDidLoad()
        if let name = name {
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }
        print("12313123123123213")
        // Do any additional setup after loading the view.
    }
    
  
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    
        // self.navigationController?. popToRootViewController(animated: true)
        // >>go to root viewController
    }
    
    
    
}
