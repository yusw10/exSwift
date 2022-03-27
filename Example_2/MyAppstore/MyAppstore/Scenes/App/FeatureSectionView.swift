import SnapKit
import UIKit

final class FeatureSectionView: UIView{
    private var featureList: [Feature]
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(
            FeatureSectionViewCell.self,
            forCellWithReuseIdentifier: "FeatureSectionViewCell"
        )
        
        return collectionView
    }()
    
    private let seperator = SeperatorView(frame: .zero)
    
    override init(frame: CGRect) {
        featureList = []
        super.init(frame: frame)
        setupViews()
        fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("ASASD")
    }
    
}

extension FeatureSectionView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureSectionViewCell", for: indexPath) as? FeatureSectionViewCell else { return UICollectionViewCell()}
        let feature = featureList[indexPath.item]
        cell.setupCell(feature: feature)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featureList.count
    }
}

extension FeatureSectionView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32.0, height: frame.width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32.0
    }
}

private extension FeatureSectionView{
    func setupViews(){
        [collectionView, seperator].forEach { UICollectionView in
            addSubview(UICollectionView)
        }
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(16)
            make.height.equalTo(snp.width)
        }
        seperator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).offset(16.0)
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview()
        }
    }
    
    func fetchData(){
        guard let url = Bundle.main.url(forResource: "Feature", withExtension: "plist") else { return }
        do{
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Feature].self, from: data)
            featureList = result
            print("completion rankingFeature list fetching")

        }catch{
            print("FETCH DATA ERROR : ranking feature data fetching error")
        }
                
    }
}
