//
//  LoginViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 유한석 on 2022/01/15.
//

import Foundation
import UIKit

class LoginViewController: UIViewController{
    @IBOutlet weak var appleLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var emailLoginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        [emailLoginButton,googleLoginButton,appleLoginButton].forEach{
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigation bar hidden
        navigationController?.navigationBar.isHidden = true
    }
    @IBAction func googleLoginButtonTapped(_ sender: UIButton) {
        //Firebase Authentification code
    }
    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
        //Firebase Authentification code
    }
}
