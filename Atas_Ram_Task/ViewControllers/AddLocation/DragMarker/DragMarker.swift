
import Foundation
import MapKit

class DragMarker: NSObject, MKAnnotation {
    
    // MARK: - Required KVO-compliant Property
    var coordinate: CLLocationCoordinate2D {
        willSet(newCoordinate) {
            let notification = NSNotification(name: NSNotification.Name(rawValue: "VTAnnotationWillSet"), object: nil)
            NotificationCenter.default.post(notification as Notification)
        }
        
        didSet {
            let notification = NSNotification(name: NSNotification.Name(rawValue: "VTAnnotationDidSet"), object: nil)
            NotificationCenter.default.post(notification as Notification)
        }
    }
    
    
    // MARK: - Required Initializer
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
   
}
