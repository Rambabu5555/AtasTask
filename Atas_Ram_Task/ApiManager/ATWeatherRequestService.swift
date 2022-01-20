
import Foundation
import AtasApiFramework

enum WeatherService: ServiceProtocol {
    
    case getWeatherData(lat:Double,long:Double,exclude:String, units: String)

    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5")!
    }
    var pathParams: String {
        return "/onecall?lat=%f&lon=%f&exclude=%@&appid=%@&units=%@"
    }
    
    var path: String {
        switch self {
        case .getWeatherData(let lat, let long, let exclude, let units):
            return String(format:pathParams, lat, long, exclude, "56c5e7bc26b990b23d8f57cde4546193", units)
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var task: Task {
        switch self {
        case .getWeatherData(lat: _, long: _, exclude: _, units: _):
            return .requestPlain
        }
    }
    
    var headers: Headers? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
}
