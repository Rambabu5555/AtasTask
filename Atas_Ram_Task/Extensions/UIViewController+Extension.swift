
import Foundation
import UIKit

extension UIViewController {
    
    /// to display alert in all UIViewController subclasses
    func showAlert(title: String, message: String, actionTitle: String) {
        // Create the alert controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func printObj(object: Any) {
        #if DEBUG
        print(object)
        #endif
    }
    /**
     *
     * Convert unix time to human readable time. Return empty string if unixtime
     * argument is 0. Note that EMPTY_STRING = ""
     *
     * @param unixdate the time in unix format, e.g. 1482505225
     * @param timezone the user's time zone, e.g. EST, PST
     * @return the date and time converted into human readable String format
     *
     **/
    func getDate(unixdate: Int, timezone: String, dateFormat: String = "MMM d") -> String {
        if unixdate == 0 {return ""}
        let date = NSDate(timeIntervalSince1970: TimeInterval(unixdate))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = dateFormat
        dayTimePeriodFormatter.timeZone = NSTimeZone(name: timezone) as TimeZone?
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return "\(dateString)"
    }
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() { 
        view.endEditing(true)
    }
}
// MARK:- UISegmentedControl Extension
extension UISegmentedControl {

    func setTitleColor(_ color: UIColor, state: UIControl.State = .normal) {
        var attributes = self.titleTextAttributes(for: state) ?? [:]
        attributes[.foregroundColor] = color
        self.setTitleTextAttributes(attributes, for: state)
    }
    
    func setTitleFont(_ font: UIFont, state: UIControl.State = .normal) {
        var attributes = self.titleTextAttributes(for: state) ?? [:]
        attributes[.font] = font
        self.setTitleTextAttributes(attributes, for: state)
    }

}
