

import UIKit

extension UITableView {
    
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() }) { _ in completion() }
    }
    func scrollToBottom() {
        
        DispatchQueue.main.async {
            let row = self.numberOfRows(inSection: self.numberOfSections - 1) - 1
            if row < 0 {
                return
            }
            let indexPath = IndexPath(
                row: row,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func scrollToTop() {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    func setFallbackView(withTitle: String, withText: String) {
        let illustrationsFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        let illustrationView = FallbackIllustrationsView.init(frame: illustrationsFrame)
        illustrationView.setFallbackTitle = withTitle
        illustrationView.setFallbackText = withText
        self.backgroundView = illustrationView
    }
    func restore() {
        self.backgroundView = nil
    }
}
