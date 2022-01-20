

import Foundation
@testable import Atas_Ram_Task

class MockAPIManager: APIManager {

    static let sharedManager = MockAPIManager()
    private override init() {
        super.init()
    }
    override func getWeatherData(lat: Double, long: Double, exclude: String, units: String = "metric", onSuccess: @escaping (Data?) -> (),
                                 onClientError: @escaping (Error) -> (),
                                 onServerError: @escaping (HTTPURLResponse, Data?) -> ()) {
        if let path = Bundle.main.path(forResource: "WeatherReportMock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  onSuccess(data)
            } catch {
                onClientError(error)
            }
        }
    }
}
