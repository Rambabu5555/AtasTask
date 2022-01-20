

import UIKit

class HomeLocationsTableViewCell: UITableViewCell {
    // MARK: - User interface objects
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    // MARK: - TableViewCell properties
    public static let identifier = "HomeLocationsTableViewCell"
    var locationData: Locations? {
        didSet {
           updateData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.addshadowToLayer(color: UIColor.gray, radius: 8)
    }
    private func updateData() {
        locationLabel.text = locationData?.name
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
