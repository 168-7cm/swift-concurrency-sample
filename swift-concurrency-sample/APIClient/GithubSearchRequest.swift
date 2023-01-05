//
//  GithubSearchRequest.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/05.
//

import Foundation

protocol RequestParameter {}

struct GithubSearchRequestParameter: RequestParameter {
    let q: String
    let order: String
}

struct GithubSearchRequest: Requestable {
    typealias Response = SearchRepositoryResponse

    var query: String?

    var url: String {
        return "https://api.github.com/search/repositories"
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

    func decode(from data: Data) throws -> SearchRepositoryResponse {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(SearchRepositoryResponse.self, from: data)
    }
}
