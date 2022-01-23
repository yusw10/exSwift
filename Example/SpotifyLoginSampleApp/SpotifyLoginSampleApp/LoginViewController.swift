//
//  LoginViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 유한석 on 2022/01/15.
//

import Foundation
import UIKit
import GoogleSignIn
import Firebase
class LoginViewController: UIViewController{
    @IBOutlet weak var appleLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    @IBOutlet weak var emailLoginButton: UIButton!
    
    let signInConfig = GIDConfiguration.init(clientID: FirebaseApp.app()?.options.clientID ?? "")
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
        
        //google signin 을 위한 인스턴스 생성
        //GIDSignIn.sharedInstance.presen
    }
    @IBAction func googleLoginButtonTapped(_ sender: UIButton) {
        //Firebase Authentification code
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("와 로그인이 된걸!?")
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            print("와 인증값을 받긴 했어!")
            Auth.auth().signIn(with: credential){ authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                    print("에러 윽엑")
                    return
                }else{
                    print("와 성공")
                    
                    showMainViewControlelr()
                }
            }
                
            
        }
        
    }
    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
        //Firebase Authentification code
    }
    
    private func showMainViewControlelr(){
        print("메인으로 가자")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        UIApplication.shared.windows.first?.rootViewController?.show(mainViewController, sender: nil)
        
    }
}
