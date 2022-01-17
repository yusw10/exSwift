//
//  MainViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 유한석 on 2022/01/17.
//

import UIKit

class MainViewController: UIViewController{
    @IBOutlet weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden =  true
    }
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
}
