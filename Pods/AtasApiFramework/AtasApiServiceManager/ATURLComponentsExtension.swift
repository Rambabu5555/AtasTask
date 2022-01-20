//
//  ATURLComponentsExtension.swift
//  Atas_Task
//
//  Created by Rambabu on 16/01/22.
//

import Foundation

extension URLComponents {
    
    init(service: ServiceProtocol) {
        let urlString = service.baseURL.appendingPathComponent(service.path).absoluteString.removingPercentEncoding ?? ""
        let url = URL(string: urlString)
        self.init(url: url!, resolvingAgainstBaseURL: false)!
        
        guard case let .requestParameters(parameters) = service.task, service.parametersEncoding == .url else { return }
        
        queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
}
