
import Foundation

class APIManager {
    
    static let shared = APIManager()
    init() {}
    /**
     This method is to fetch the search results from server using search string
     - Parameter searchString: value to search
     */
    func getWeatherData(lat: Double, long: Double, exclude: String, units: String, onSuccess: @escaping (Data?) -> (),
                 onClientError: @escaping (Error) -> (),
                 onServerError: @escaping (HTTPURLResponse, Data?) -> ()) {
        let weatherUrl = WebServiceUrlEndpoint.getWeatherApi(lat: lat, long: long, exclude: exclude, units: units).url()
        WebServices.shared.getRequest(url: weatherUrl) { (data) in
            onSuccess(data)
        } onClientError: { (Error) in
            onClientError(Error)
        } onServerError: { (HTTPURLResponse, data) in
            onServerError(HTTPURLResponse,data)
        }
    }
}
