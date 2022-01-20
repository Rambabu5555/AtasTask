
import Foundation

class WebServices: NSObject {
    static let shared = WebServices()
    private override init() {}
    // MARK: - Get Request
    func getRequest(url: String, onSuccess: @escaping (Data?) -> (),
                    onClientError: @escaping (Error) -> (),
                    onServerError: @escaping (HTTPURLResponse, Data?) -> ()) {
        URLSession.shared.dataTask(with: URL.init(string: url)!) { data, response, error in
            #if DEBUG
            print("---------------- Responce --------------------")
            print("url: \(url)")
            print("Responce: \(String(describing: response))")
            print("Error: \(String(describing: error))")
            print("---------------- Responce --------------------")
            #endif
            DispatchQueue.main.async {
                if let error = error {
                    onClientError(error)
                    return
                }
                if let httpResponse = response as? HTTPURLResponse,
                   !(200...299).contains(httpResponse.statusCode) {
                    onServerError(httpResponse, data)
                    print("error "+httpResponse.debugDescription)
                    return
                }
                onSuccess(data)
            }
        }.resume()
    }
}
