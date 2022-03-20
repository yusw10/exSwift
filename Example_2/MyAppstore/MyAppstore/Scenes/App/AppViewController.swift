//
//  AppViewController.swift
//  MyAppstore
//
//  Created by 유한석 on 2022/03/18.
//

import UIKit
import SnapKit
import Then


final class AppViewController: UIViewController{
    
    private lazy var scrollView = UIScrollView().then{
        $0.addSubview(contentView)
    }
    private lazy var contentView = UIView().then{
        $0.addSubview(stackView)
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing // 각각의 높이가 다 다르기 때문에 간격만 동일하게 해준다,.
        stackView.spacing = 0.0 // 이렇게 하면 스택뷰는 본인들의 높이대로 크기가 정해진다.
        
        let featureSectionView = FeatureSectionView(frame: .zero)
        let rankingFeatureSectionView = RankingFeatureSectionView(frame: .zero)
        let exchangeCodeButtonSection = ExchangeCodeButtonView()
        
        let spacingView = UIView().then{
            $0.snp.makeConstraints { ConstraintMaker in
                ConstraintMaker.height.equalTo(100.0)
            }
        }
        
        [ featureSectionView, rankingFeatureSectionView, exchangeCodeButtonSection, spacingView].forEach {
           stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupLayout()
    }
}

private extension AppViewController{
    func setupNavigationController(){
        navigationItem.title = "앱"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout(){
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview() // 가로는 고정된 세로스크롤이 완성된다.
        }
        
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
