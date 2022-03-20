//
import SnapKit
import Then
import UIKit

final class AppDetailViewController: UIViewController {
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
    }
    
}
