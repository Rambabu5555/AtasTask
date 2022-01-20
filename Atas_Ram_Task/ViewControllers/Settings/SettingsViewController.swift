
import UIKit
protocol SettingsUpdatedDelegate: class {
    func settingsUpdated()
}
class SettingsViewController: UIViewController {
    // MARK: - User interface objects
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var unitSegment: UISegmentedControl!
    weak var delegate: SettingsUpdatedDelegate?
    // MARK: - ViewController delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadows()
        customiseSegment()
        updatePreviouslySelectedValue()
    }
    // MARK: - Utilities
    private func updatePreviouslySelectedValue() {
        if UserDefaults.getMetricSelected() == "metric" {
            unitSegment.selectedSegmentIndex = 0
        } else {
            unitSegment.selectedSegmentIndex = 1
        }
    }
    private func customiseSegment() {
        unitSegment.setTitleColor(UIColor(named: "textColot")!)
        unitSegment.setTitleFont(UIFont(name: "Menlo Bold", size: 14)!)
    }
    
    private func addShadows(){
        /// adding shadow to subviews
        closeButton.layer.addshadowToLayer(color: UIColor(named: "textColot")!, radius: 8)
    }
    
    // MARK: - Button Actions
    @IBAction func didTapOnCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func unitSegmentValueChanged(_ sender: Any) {
        if unitSegment.selectedSegmentIndex == 0 {
            UserDefaults.saveMetricSelected(type: "metric")
        } else {
            UserDefaults.saveMetricSelected(type: "imperial")
        }
        delegate?.settingsUpdated()
    }
}
