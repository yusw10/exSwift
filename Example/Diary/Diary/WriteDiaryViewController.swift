//
//  WriteDiaryViewController.swift
//  Diary
//
//  Created by 유한석 on 2021/12/15.
//

import UIKit

class WriteDiaryViewController: UIViewController {
    @IBOutlet var confirmButton: UIBarButtonItem!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var titleTextField: UITextField!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configureContentsTextView()
    }
  
    @IBAction func tapConfirmButton(_ sender: UIBarButtonItem) {
    }
    
    private func configureContentsTextView(){
        //uicolor는 0 ~ 1 사이 값이므로 255 scalef 맞춰준다
        let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        self.contentsTextView.layer.borderColor = borderColor.cgColor
        self.contentsTextView.layer.borderWidth = 0.5
        self.contentsTextView.layer.cornerRadius = 5.0
    }
}
