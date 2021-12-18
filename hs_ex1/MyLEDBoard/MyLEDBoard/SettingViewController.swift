//
//  SettingViewController.swift
//  MyLEDBoard
//
//  Created by 유한석 on 2021/12/08.
//

import UIKit

protocol MyLEDBoardSettingDelegate: AnyObject{
    func changedSetting(text:String?, textColor: UIColor, backgroundColor: UIColor, font: String)
}


class SettingViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    @IBOutlet weak var fontOneButton: UIButton!
    @IBOutlet weak var fontTwoButton: UIButton!
    @IBOutlet weak var fontThreeButton: UIButton!
    
    weak var delegate: MyLEDBoardSettingDelegate?
    var text :String?
    var textColor: UIColor = .yellow
    var backgroundColor: UIColor =  .black
    var font: String = "One"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    private func configureView(){
        if let text = text {
            self.textField.text = text
        }
        changeTextColor(textColor: textColor)
        changeBackgroundColor(backgroundColor: backgroundColor)
        changeFont(fontName: font)
    }
    
    @IBAction func tapTextColorChange(_ sender: UIButton) {
        if sender == yellowButton{
            changeTextColor(textColor: .yellow)
            self.textColor = .yellow
        }else if sender == purpleButton{
            changeTextColor(textColor: .purple)
            self.textColor = .purple
        }else if sender == orangeButton {
            changeTextColor(textColor: .orange)
            self.textColor = .orange
        }else{
            print("???")
        }
    }
    
    @IBAction func tapBackgroundColor(_ sender: UIButton) {
        if sender == blackButton{
            changeBackgroundColor(backgroundColor: .black)
            self.backgroundColor = .black
        }else if sender == blueButton{
            changeBackgroundColor(backgroundColor: .blue)
            self.backgroundColor = .blue
        }else if sender == greenButton{
            changeBackgroundColor(backgroundColor: .green)
            self.backgroundColor = .green
        }else{
            print("!!!")
        }
    }
    
    @IBAction func tapFontChange(_ sender: UIButton) {
        if sender == fontOneButton{
            changeFont(fontName: "One")
            self.font = "One"
        }else if sender == fontTwoButton{
            changeFont(fontName: "Two")
            self.font = "Two"
        }else if sender == fontThreeButton{
            changeFont(fontName: "Three")
            self.font = "Three"
        }
    }
    @IBAction func tapSaveButton(_ sender: UIButton) {
//        self.delegate?.changedSetting(
//            text: self.textField.text,
//            textColor: self.textColor,
//            backgroundColor: self.backgroundColor
//        )
//        self.navigationController?.popViewController(animated: true)
        self.delegate?.changedSetting(text: self.textField.text, textColor: self.textColor, backgroundColor: self.backgroundColor, font: self.font)
        self.navigationController?.popViewController(animated: true)
    }
    func changeTextColor(textColor: UIColor){
        self.yellowButton.alpha = textColor == UIColor.yellow ? 1 : 0.2
        self.purpleButton.alpha = textColor == UIColor.purple ? 1: 0.2
        self.orangeButton.alpha = textColor == UIColor.orange ? 1 : 0.2
    }
    func changeBackgroundColor(backgroundColor: UIColor){
        self.blueButton.alpha = backgroundColor == UIColor.blue ? 1 : 0.2
        self.blackButton.alpha = backgroundColor == UIColor.black ? 1 : 0.2
        self.greenButton.alpha = backgroundColor == UIColor.green ? 1 : 0.2
    }
    func changeFont(fontName: String){
        self.fontOneButton.alpha = fontName == "One" ? 1 : 0.2
        self.fontTwoButton.alpha = fontName == "Two" ? 1 : 0.2
        self.fontThreeButton.alpha = fontName == "Three" ? 1 : 0.2
    }
    

}
