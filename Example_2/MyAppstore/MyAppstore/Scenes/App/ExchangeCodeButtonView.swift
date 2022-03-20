//
//  ExchangeCodeButtonView.swift
//  MyAppstore
//
//  Created by 유한석 on 2022/03/20.
//

import SnapKit
import UIKit

final class ExchangeCodeButtonView: UIView{
    private var exchangeCodeButton = UIButton().then{
        $0.setTitle("코드 교환", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        
        $0.backgroundColor = .tertiarySystemGroupedBackground
        $0.layer.cornerRadius = 7.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(exchangeCodeButton)
        exchangeCodeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.0)
            make.trailing.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().inset(32.0)
            make.bottom.equalToSuperview().inset(32.0)
            make.height.equalTo(40.0)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("exchanger button initerror")
    }
}
