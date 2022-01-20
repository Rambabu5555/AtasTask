
import Foundation
import AtasApiFramework

class HomeDetailsViewModel: NSObject {
    var apiManager: APIManager!
    var weatherData: WeatherReport?
    let sessionProvider = ATURLSessionProvider()

    init(apimanager: APIManager) {
        self.apiManager = apimanager
        super.init()
    }

    func getWeatherResults(withLat: Double, withLong: Double, withExclude: String, units: String = "metric", completion: @escaping ( _ status: Bool, _ error: String?) -> ()) {
        apiManager.getWeatherData(lat: withLat, long: withLong, exclude: withExclude, units: units) { (data) in
            let jsonDecoder = JSONDecoder()
            do {
                let responseModel = try jsonDecoder.decode(WeatherReport.self, from: data!)
                print(responseModel)
                self.weatherData = responseModel
                completion(true, nil)
            } catch let error {
                print(error.localizedDescription)
                completion(false, error.localizedDescription)
            }

        } onClientError: { (error) in
            print(error)
            completion(false, error.localizedDescription)
        } onServerError: { (responce, data) in
            completion(false, "")
        }
    }
    
    /// api call from pods
    func getWeatherResultsFromPods(withLat: Double, withLong: Double, withExclude: String, units: String = "metric", completion: @escaping ( _ status: Bool, _ error: String?) -> ()) {
        sessionProvider.request(type: WeatherReport.self, service: WeatherService.getWeatherData(lat: withLat, long: withLong, exclude: withExclude, units: units)) { response in
            switch response {
            case let .success(weatherData):
                print(weatherData)
                self.weatherData = weatherData
                completion(true, nil)
            case let .failure(error):
                print(error)
                completion(false, "\(error)")
            }
        }
    }
}
