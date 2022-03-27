//
//  RankingFeatureSectionView.swift
//  MyAppstore
//
//  Created by 유한석 on 2022/03/20.
//

import SnapKit
import UIKit
import Then

final class RankingFeatureSectionView: UIView {
    private var rankingFeatureList: [RankingFeature] = []
    
    private var titleLabel = UILabel().then{ make in
        make.font = .systemFont(ofSize: 18, weight: .black)
    }
    private var showAllAppsButton = UIButton().then{ make in
        make.setTitle("모두보기", for: .normal)
        make.setTitleColor(.systemBlue, for: .normal)
        make.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
    }
    
    private var layout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 32.0
        $0.minimumInteritemSpacing = 0.0
        $0.sectionInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then{ make in
        make.delegate = self
        make.dataSource = self
        make.isPagingEnabled = true
        make.backgroundColor = .systemBackground
        make.showsHorizontalScrollIndicator = false
        
        make.register(RankingFeatureSectionViewCell.self,forCellWithReuseIdentifier: "RankingFeatureSectionViewCell")
    }
    
    private var seperator = SeperatorView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("ranking section init error")
    }
}


extension RankingFeatureSectionView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rankingFeatureList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingFeatureSectionViewCell", for: indexPath) as? RankingFeatureSectionViewCell else { return UICollectionViewCell()}
        let rankingFeature = rankingFeatureList[indexPath.item]
        cell.setup(rankingFeature: rankingFeature)
        
        return cell
    }
}

extension RankingFeatureSectionView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.width - 32,
            height: RankingFeatureSectionViewCell.height
        )
    }
}

private extension RankingFeatureSectionView{
    func setupViews(){
        [titleLabel, showAllAppsButton, collectionView, seperator].forEach { UIView in
            addSubview(UIView)
        }
        titleLabel.text = "게헤헤"
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16.0)
            make.leading.equalToSuperview().inset(16.0)
            make.trailing.equalTo(showAllAppsButton.snp.leading).offset(8)
        }
        showAllAppsButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(titleLabel.snp.bottom)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(RankingFeatureSectionViewCell.height * 3)
        }
        seperator.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).offset(16)
        }
    }
    
    func fetchData(){
        guard let url = Bundle.main.url(forResource: "RankingFeature", withExtension: "plist") else { return }
        do{
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([RankingFeature].self, from: data)
            rankingFeatureList = result
        }catch{
            print("FETCH ERROR : fetching error - ranking feature data ")
        }
    }
}
