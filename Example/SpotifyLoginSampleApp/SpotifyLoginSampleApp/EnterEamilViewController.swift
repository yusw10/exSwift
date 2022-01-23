//
//  EnterEamilViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 유한석 on 2022/01/15.
//

import Foundation
import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController{
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.layer.cornerRadius = 30
        self.nextButton.isEnabled = false
        self.nextButton.alpha = 0
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.becomeFirstResponder()
        print("complete ViewdidLoad")
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        //Firebase email, password authentification
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        
        //신규 사용자 생성
        
        print("before create user")
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult , error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007: // 이미 가입한 계정
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
            }else{
                self.showMainViewController()
            }
            
        }
    }
    private func loginUser(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password){ [weak self] _ , error in
            guard let self = self else { return }
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            }else{
                self.showMainViewController()
            }
        }
    }
    private func showMainViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
}

extension EnterEmailViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
        if nextButton.isEnabled {
            nextButton.alpha = 1
        }
    }
}
