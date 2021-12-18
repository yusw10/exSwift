//
//  ViewController.swift
//  QuotesGenerator
//
//  Created by 유한석 on 2021/12/03.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var qutoeLabel: UILabel!
    let Quotes = [
        Quote(content: "내로남불", name: "김민균"),
        Quote(content: "흐음... 패가 안좋네", name: "권종수"),
        Quote(content: "알빠야?", name: "강지윤"),
        Quote(content: "아니 야 근데", name: "민경환"),
        Quote(content: "후완후완루", name: "유한석"),
        Quote(content: "와 중간고사 안봄", name: "김규태"),
        Quote(content: "보안 ㄱㄱ", name: "이장우"),
        Quote(content: "전기기사 ㄱㄱ", name: "염규현"),
        Quote(content: "...", name: "임진혁")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapQuoteGeneratorButton(_ sender: Any) {
        let random = Int(arc4random_uniform(9))
        let quote = Quotes[random]
        self.qutoeLabel.text = quote.content
        self.nameLabel.text = quote.name
        
    }
    
}

