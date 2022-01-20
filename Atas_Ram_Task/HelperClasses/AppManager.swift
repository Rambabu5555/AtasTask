
import UIKit

// MARK: - Utilities
struct App {
    /// isRunningOnIpad: this will return wether the device is iPad or iPhone
    static let isRunningOnIpad = UIDevice.current.userInterfaceIdiom == .pad ? true : false
    /// isRunningOnIpad: this will return wether the device has notch or not
    static var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            // with notch: 44.0 on iPhone X, XS, XS Max, XR.
            // without notch: 24.0 on iPad Pro 12.9" 3rd generation, 20.0 on iPhone 8 on iOS 12+.
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 >= 24
        }
        return false
    }
}
