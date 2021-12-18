//
//  SuguePresentViewController.swift
//  ScreenTransactionExample
//
//  Created by 유한석 on 2021/12/04.
//

import UIKit

class SeguePresentViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
