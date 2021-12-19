//
//  WriteDiaryViewController.swift
//  Diary
//
//  Created by 유한석 on 2021/12/15.
//

import UIKit

protocol WriteDiaryViewDelegate:AnyObject{
    func didSelectRegister(diary: Diary)
}

class WriteDiaryViewController: UIViewController {
    @IBOutlet var confirmButton: UIBarButtonItem!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var titleTextField: UITextField!
    
    weak var delegate: WriteDiaryViewDelegate?
    
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configureContentsTextView()
        configureDatePicker()
        self.confirmButton.isEnabled = false
        configureInputField()
    }
  
    @IBAction func tapConfirmButton(_ sender: UIBarButtonItem) {
        guard let title = self.titleTextField.text else{return}
        guard let contents = self.contentsTextView.text else {return}
        guard let date = self.diaryDate else {return}
        let diary = Diary(title: title, contents: contents, date: date, isStar: false)
        self.delegate?.didSelectRegister(diary: diary)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureDatePicker(){
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        self.dateTextField.inputView = self.datePicker
        self.datePicker.locale = Locale(identifier: "ko_KR")
    }
    private func configureInputField(){
        self.contentsTextView.delegate = self
        self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        self.dateTextField.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func configureContentsTextView(){
        //uicolor는 0 ~ 1 사이 값이므로 255 scalef 맞춰준다
        let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        self.contentsTextView.layer.borderColor = borderColor.cgColor
        self.contentsTextView.layer.borderWidth = 0.5
        self.contentsTextView.layer.cornerRadius = 5.0
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker){
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formmater.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        self.dateTextField.text = formmater.string(from: datePicker.date)
        self.dateTextField.sendActions(for: .editingChanged )
    }
    
    @objc private func titleTextFieldDidChange(_ textField:UITextField){
        self.validateInputField()
    }
    @objc private func dateTextFieldDidChange(_ textField: UITextField){
        self.validateInputField()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func validateInputField(){
        self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.dateTextField.text?.isEmpty ?? true) && !self.contentsTextView.text.isEmpty
    }
}

extension WriteDiaryViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
        
    }
}
