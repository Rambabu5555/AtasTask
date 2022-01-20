

import Foundation
import UIKit

extension CALayer {
    func addshadowToLayer(color: UIColor, radius: Int ) {
        self.masksToBounds = false
        self.shadowColor = color.cgColor
        self.shadowOpacity = 0.4
        self.shadowOffset = CGSize(width: -1, height: 3)
        self.shadowRadius = CGFloat(radius)
        self.shouldRasterize = false
        self.rasterizationScale = 1.0
    }
}
