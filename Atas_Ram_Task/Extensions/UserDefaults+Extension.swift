

import Foundation
extension UserDefaults {

    static let disableMarkerAlertKey: String = "disableMarkerAlert"
    static let metricSelected: String = "METRIC_SELECTED"

    static func disableMarkerAlert() {
        UserDefaults.standard.set(true, forKey: disableMarkerAlertKey)
    }
    static func getMetricSelected() -> String {
        return  UserDefaults.standard.value(forKey: metricSelected) as? String ?? "metric"
    }
    static func saveMetricSelected(type: String) {
        UserDefaults.standard.setValue(type, forKey: metricSelected)
    }
}
