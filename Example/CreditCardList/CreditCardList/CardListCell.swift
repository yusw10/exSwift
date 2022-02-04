//
//  CardListCell.swift
//  CreditCardList
//
//  Created by 유한석 on 2022/02/05.
//

import UIKit

class CardListCell: UITableViewCell {
    @IBOutlet weak var cardImageView: UIImageView!
    
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var promotionLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
