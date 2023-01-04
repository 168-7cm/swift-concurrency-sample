//
//  Requestable.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/04.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

typealias Headers = [String: String]

protocol Requestable {
    associatedtype Response
    var url: String { get }
    var httpMethod: HttpMethod { get }
    var headers: Headers { get }
    var body: Data? { get }
    func decode(from data: Data) throws -> Response
}

extension Requestable {
    var urlRequest: URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        request.httpBody = body
        return request
    }
}
