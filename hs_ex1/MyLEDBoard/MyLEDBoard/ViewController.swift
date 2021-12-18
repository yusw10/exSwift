//
//  ViewController.swift
//  MyLEDBoard
//
//  Created by 유한석 on 2021/12/08.
//

import UIKit

class ViewController: UIViewController, MyLEDBoardSettingDelegate {

    @IBOutlet weak var MainLabel: UILabel!
    var font: String = "One"
    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor, font: String) {
        self.MainLabel.text = text
        self.MainLabel.textColor = textColor
        self.view.backgroundColor = backgroundColor
        changeFont(font: font)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MainLabel.textColor = .yellow
        self.MainLabel.font = UIFont(name: "NanumGangInHanWiRo", size: CGFloat(50))
        for family: String in UIFont.familyNames {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingViewController = segue.destination as? SettingViewController{
            settingViewController.delegate = self
            settingViewController.text = self.MainLabel.text
            settingViewController.textColor = self.MainLabel.textColor
            settingViewController.backgroundColor = self.view.backgroundColor ?? .black
            settingViewController.font = self.font
        }
    }
    
    private func changeFont(font: String?){
        if font == "One"{
            print("One")
            self.MainLabel.font = UIFont(name: "NanumGangInHanWiRo", size: CGFloat(50))
            self.font = "One"
        }else if font == "Two"{
            print("Two")
            self.MainLabel.font = UIFont(name: "NanumGomSinCe", size: CGFloat(50))
            self.font = "Two"
        }else if font == "Three"{
            print("Three")
            self.MainLabel.font = UIFont(name: "NanumBeomSomCe", size: CGFloat(50))
            self.font = "Three"
        }else{
            print("change font error")
        }
        
    }
    
}

