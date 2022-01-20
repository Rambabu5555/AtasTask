
import UIKit

class WeatherDetailsTableHeaderView: UIView {
    // MARK: - User interface objects
    @IBOutlet weak var sectionHeaderLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
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
        UINib(nibName: "WeatherDetailsTableHeaderView", bundle: nil).instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }

}
