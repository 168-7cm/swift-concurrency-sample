//
//  SearchUserRequest.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/05.
//

import Foundation

struct SearchUserRequest: Requestable {
    typealias Response = SearchUserResponse

    var query: String?

    var url: String {
        return "https://api.github.com/search/users"
    }

    var httpMethod: HttpMethod {
        return .get
    }

    var headers: Headers {
        var headers: Headers = [:]
        headers.updateValue("application/vnd.github.v3+json", forKey: "Accept")
        return headers
    }

    var parameters: [String : String?] {
        return ["q": query]
    }

    func decode(from data: Data) throws -> SearchUserResponse {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(SearchUserResponse.self, from: data)
    }
}
