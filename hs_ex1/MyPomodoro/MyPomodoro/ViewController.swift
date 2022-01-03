//
//  ViewController.swift
//  MyPomodoro
//
//  Created by 유한석 on 2022/01/03.
//

import UIKit
enum timerStatus{
    case start
    case pause
    case end
}

class ViewController: UIViewController {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var toggleButton: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var timerStatus:timerStatus = .end
    var duration = 60
    var timer:DispatchSourceTimer?
    var currentTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitiateView()
        // Do any additional setup after loading the view.
    }
    
    private func configureInitiateView(){
        self.cancelButton.isEnabled = false
        self.progressView.alpha = 0
        self.timeLabel.alpha = 0
        self.datePicker.alpha = 1
        self.toggleButton.setTitle("시작", for: .normal)
        self.toggleButton.setTitle("일시정지", for: .selected)
    }
    private func startTimer(){
        if self.timer == nil{
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.timer?.schedule(deadline: .now(), repeating: 1)
            self.timer?.setEventHandler(handler: {
                self.currentTime -= 1
                
                let hour = self.currentTime / 3600
                let minutes = (self.currentTime % 3600) / 60
                let seconds = (self.currentTime % 3600) % 60
                self.timeLabel.text = String(format: "%02d:%02d:%02d", hour,minutes,seconds)
                self.progressView.progress = Float(self.currentTime) / Float(self.duration)
                
                if self.currentTime <= 0{
                    self.stopTimer()
                    debugPrint("audio alarm")
                }
                
            })
            self.timer?.resume()
        }
    }
    private func stopTimer(){
        if self.timerStatus == .pause {
            self.timerStatus = .start
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.progressView.alpha = 0
            self.timeLabel.alpha = 0
            self.datePicker.alpha = 1
        })
        self.toggleButton.isSelected = false
        self.cancelButton.isEnabled = false
        self.timer?.cancel()
        self.timer = nil
    }
    
    @IBAction func tapCancelButton(_ sender: UIButton) {
        self.stopTimer()
    }
    
    @IBAction func tapToggleButton(_ sender: Any) {
        self.duration = Int(self.datePicker.countDownDuration)
        switch timerStatus {
        case .start: // 돌아가는중에 일시정지
            self.toggleButton.isSelected = true
            self.timerStatus = .pause
            self.timer?.suspend()
        case .pause: // 일시정지중에 다시 시작
            self.timerStatus = .start
            self.toggleButton.isSelected = true
            self.timer?.resume()
        case .end: // 처음에서 시작버튼
            self.timerStatus = .pause
            self.currentTime = self.duration
            self.cancelButton.isEnabled = true
            self.toggleButton.isSelected = false
            UIView.animate(withDuration: 0.5, animations: {
                self.datePicker.alpha = 0
                self.timeLabel.alpha = 1
                self.progressView.alpha = 1
            })
            self.startTimer()
        }
    }
    
}

