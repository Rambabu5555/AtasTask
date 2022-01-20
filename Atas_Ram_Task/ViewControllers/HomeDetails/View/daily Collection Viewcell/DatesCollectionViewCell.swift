
import UIKit

class DatesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.backgroundColor =  UIColor(named: "secondaryColor")!
        bgView.layer.addshadowToLayer(color: UIColor(named: "secondaryColor0.3")!, radius: 8)
    }

}
