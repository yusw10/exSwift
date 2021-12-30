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
enum DiaryEditorMode{
    case new
    case edit(IndexPath, Diary)
}
class WriteDiaryViewController: UIViewController {
    @IBOutlet var confirmButton: UIBarButtonItem!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var titleTextField: UITextField!
    
    weak var delegate: WriteDiaryViewDelegate?
    
    var diaryEditorMode: DiaryEditorMode = .new
    
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.confirmButton.isEnabled = false
        self.configureContentsTextView()
        self.configureDatePicker()
        self.configureInputField()
        self.configureEditMode()
    }
  
    @IBAction func tapConfirmButton(_ sender: UIBarButtonItem) {
        guard let title = self.titleTextField.text else{return}
        guard let contents = self.contentsTextView.text else {return}
        guard let date = self.diaryDate else {return}
        
        
        //수정된 내용을 전달하는 notification 객체를 전달

        switch self.diaryEditorMode{
        case .new:
            let diary = Diary(uuidString: UUID().uuidString,title: title, contents: contents, date: date, isStar: false)
            self.delegate?.didSelectRegister(diary: diary)
        case let .edit(indexPath, diary):
            let diary = Diary(uuidString: diary.uuidString ,title: title, contents: contents, date: date, isStar: diary.isStar)
            NotificationCenter.default.post(
                name: NSNotification.Name("editDiary"),
                object: diary,
                userInfo: nil
            )
        }
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
    
    private func configureEditMode(){
        switch self.diaryEditorMode{
        case let .edit(_, diary):
            self.titleTextField.text = diary.title
            self.contentsTextView.text = diary.contents
            self.dateTextField.text = self.dateToString(date: diary.date)
            self.diaryDate = diary.date
            self.confirmButton.title = "수정"
        default:
            break
        }
    }
    private func dateToString(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}

extension WriteDiaryViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
        
    }
}
