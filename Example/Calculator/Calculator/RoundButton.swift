//
//  isRound.swift
//  MyCalculator
//
//  Created by 유한석 on 2021/12/11.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var isRound: Bool = false{
        didSet{
            if isRound{
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }

}
