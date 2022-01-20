//
//  ATServiceProtocol.swift
//  Atas_Task
//
//  Created by Rambabu on 16/01/22.
//

import Foundation

public typealias Headers = [String: String]
public typealias Parameters = [String: Any]

//MARK: - ServiceProtocol -
public protocol ServiceProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: Headers? { get }
    var parametersEncoding: ParametersEncoding { get }
}
//MARK: - HTTPMethod -
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
//MARK: - Task -
public enum Task {
    case requestPlain
    case requestParameters(Parameters)
}
//MARK: - ParametersEncoding -
public enum ParametersEncoding {
    case url
    case json
}
