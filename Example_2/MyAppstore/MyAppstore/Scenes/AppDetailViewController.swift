//
import SnapKit
import Then
import UIKit

final class AppDetailViewController: UIViewController {
    private let today: Today
    
    private var appIconImageView = UIImageView().then{ make in
        make.contentMode = .scaleAspectFit
        make.clipsToBounds = true
        make.layer.cornerRadius = 8.0
    }
    
    private var titleLabel = UILabel().then{ make in
        make.font = .systemFont(ofSize: 20.0, weight: .bold)
    }
    
    private var subTitleLabel = UILabel().then{
        $0.font = .systemFont(ofSize: 14.0, weight: .medium)
        $0.textColor = .secondaryLabel
    }
    private var downloadButton = UIButton().then{make in
        make.setTitle("닫기", for: .normal)
        make.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        make.backgroundColor = .systemBlue
        make.setTitleColor(.white, for: .normal)
        make.layer.cornerRadius = 12.0
    }
    private var shareButton = UIButton().then{ make in
        make.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        make.tintColor = .systemBlue
    }
    init(today: Today){
        self.today = today
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        
        appIconImageView.backgroundColor = .lightGray
        titleLabel.text = today.title
        subTitleLabel.text = today.subTitle
    }
}
//MARK: Private
private extension AppDetailViewController{
    func setupViews(){
        [appIconImageView,
         titleLabel,
         subTitleLabel,
         downloadButton,
         shareButton
        ].forEach { UIView in
            view.addSubview(UIView)
        }
        
        appIconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().inset(32.0)
            make.height.equalTo(100.0)
            make.width.equalTo(appIconImageView.snp.height)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(appIconImageView.snp.trailing).offset(16.0)
            make.trailing.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().inset(32.0)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview().inset(16.0)
        }
        downloadButton.snp.makeConstraints { make in
            make.width.equalTo(60.0)
            make.height.equalTo(32.0)
            make.leading.equalTo(appIconImageView.snp.trailing).offset(16.0)
            make.bottom.equalTo(appIconImageView.snp.bottom)
        }
        shareButton.snp.makeConstraints { make in
            make.width.height.equalTo(32.0)
            make.trailing.equalToSuperview().inset(16.0)
            make.bottom.equalTo(appIconImageView.snp.bottom)
        }
        
        
    }
}
