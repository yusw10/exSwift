//
//  CardDetailViewController.swift
//  CreditCardList
//
//  Created by 유한석 on 2022/02/06.
//

import UIKit
import Lottie

class CardDetailViewController: UIViewController{
    var promotionDetail: PromotionDetail?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var benefitConditionLabel: UILabel!
    @IBOutlet weak var benefitDetailLabel: UILabel!
    @IBOutlet weak var benefitDateLabel: UILabel!
    
    @IBOutlet weak var lottieView: AnimationView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = AnimationView(name: "money")
        lottieView.contentMode = .scaleAspectFill
        lottieView.addSubview(animationView)
        animationView.frame = lottieView.bounds
        animationView.loopMode = .loop
        animationView.play()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let detail = promotionDetail else {
            return
        }
        titleLabel.text = """
        \(detail.companyName) 카드 쓰면
        \(detail.amount)만원을 드려요
        """
        periodLabel.text = detail.period
        conditionLabel.text = detail.condition
        benefitDateLabel.text = detail.benefitDate
        benefitDetailLabel.text = detail.benefitDetail
        benefitConditionLabel.text = detail.benefitCondition
    }
}
