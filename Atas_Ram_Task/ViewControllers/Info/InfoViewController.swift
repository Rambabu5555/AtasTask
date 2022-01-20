

import UIKit
import WebKit

class InfoViewController: UIViewController {
    // MARK: - User interface objects
    @IBOutlet weak var infoWebView: WKWebView!
    @IBOutlet weak var closeButton: UIButton!
    // MARK: - ViewController delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        webKitSetup()
        addShadows()
        // Do any additional setup after loading the view.
    }
    // MARK: - Utilities
    private func webKitSetup(){
        infoWebView.load(NSURLRequest(url: NSURL(string: "https://support.apple.com/en-in/guide/iphone/iph75e97af9b/ios")! as URL) as URLRequest)
    }
    private func addShadows(){
        /// adding shadow to subviews
        infoWebView.layer.addshadowToLayer(color: UIColor(named: "textColot")!, radius: 8)
        closeButton.layer.addshadowToLayer(color: UIColor(named: "textColot")!, radius: 8)
    }
    // MARK: - Button Actions
    @IBAction func didTapCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
