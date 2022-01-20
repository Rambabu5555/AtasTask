

import Foundation

// MARK: - API Constants
public var app_id = "fae7190d7e6433ec3a45285ffcf55c86"
public var weather_api = "https://api.openweathermap.org/data/2.5/onecall?lat=%f&lon=%f&exclude=%@&appid=%@&units=%@"

public var image_url = "http://openweathermap.org/img/wn/%@@2x.png"

// MARK: - WebServiceUrlEndpoint
enum WebServiceUrlEndpoint {
    case getWeatherApi(lat:Double,long:Double,exclude:String, units: String)
    func url() -> String {
        switch self {
        case .getWeatherApi(let lat, let long, let exclude, let units):
            return  String(format: weather_api,lat,long,exclude,app_id, units)
        }
    }
}

// MARK: - ImageServiceUrlEndpoint
enum ImageServiceUrlEndpoint {
    case getWeatherImage(name: String)
    func url() -> String {
        switch self {
        case .getWeatherImage(let name):
            return  String(format: image_url,name)
        }
    }
}
// MARK: - Get Extension Based on metric selected
enum GetExtensionMetric {
    case getMetric
    func type() -> String {
        let metricSelected = UserDefaults.getMetricSelected()
        switch self {
        case .getMetric:
            if metricSelected == "metric" {
                return  "°C"
            } else {
                return  "°F"
            }
        }
    }
}
