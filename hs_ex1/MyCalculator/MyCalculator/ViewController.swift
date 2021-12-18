//
//  ViewController.swift
//  MyCalculator
//
//  Created by 유한석 on 2021/12/11.
//

import UIKit

enum Operator{
    case Add
    case Minus
    case Multiply
    case Divide
    case Mod
    case unknown
}

class ViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    var firstOperation = ""
    var secondOperation = ""
    var currentOperator: Operator = .unknown
    var result = ""
    var displayNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.outputLabel.text = "0"
        // Do any additional setup after loading the view.
    }


    @IBAction func tapNumberButton(_ sender: UIButton) {
        guard let numberValue = sender.titleLabel?.text else { return }
        if self.displayNumber.count < 9{
            displayNumber += numberValue
            self.outputLabel.text = self.displayNumber
        }
    }
    
    @IBAction func tapDotButton(_ sender: UIButton) {
    }
    
    
    @IBAction func tapEqualButton(_ sender: UIButton) {
    }
    
    @IBAction func tapOperationButton(_ sender: UIButton) {
    }
    
    @IBAction func tapRootButton(_ sender: UIButton) {
    }
    
    
}

