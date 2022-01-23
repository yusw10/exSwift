//
//  MainViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 유한석 on 2022/01/17.
//

import UIKit
import FirebaseAuth
 
class MainViewController: UIViewController{
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden =  true
        
        let email = Auth.auth().currentUser?.email ?? "고객"
        debugPrint("Email : \(email)")
        self.welcomeLabel.text = """
        환영합니다.
        \(email)님
        """
        let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password"
        resetPasswordButton.isHidden = !isEmailSignIn
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        }catch let signOutError as NSError{
            print("ERROR : signout \(signOutError.localizedDescription)")
        }
        
        
        
    }
    
    @IBAction func resetPaswordButtonTapped(_ sender: UIButton) {
        let email = Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
        
    }
}
