
import UIKit

class FallbackIllustrationsView: UIView {
    @IBOutlet weak var fallBackTitleLabel: UILabel!
    @IBOutlet weak var fallBackDiscriptionLabel: UILabel!
    @IBOutlet var contentView: UIView!
    var setFallbackText: String = "" {
        didSet {
            fallBackDiscriptionLabel.text = setFallbackText
        }
    }
    var setFallbackTitle: String = "" {
        didSet {
            fallBackTitleLabel.text = setFallbackTitle
        }
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialiseView()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialiseView()
    }
    // MARK: - Initial Methods
    private func initialiseView() {
        UINib(nibName: "FallbackIllustrationsView", bundle: nil).instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }

}
