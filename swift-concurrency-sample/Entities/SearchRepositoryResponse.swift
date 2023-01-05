//
//  GithubSearchResponse.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/05.
//

import UIKit

struct SearchRepositoryResponse: Decodable {
    let totalCount: Int?
    let items: [Repository]?

    static var empty: SearchRepositoryResponse {
        return SearchRepositoryResponse(totalCount: nil, items: nil)
    }
}

struct Repository: Decodable, Hashable, Identifiable {
    let id: Int?
    let name: String?
    let description: String?
    let stargazersCount: Int?
    let language: String?
    let htmlUrl: String?
    let owner: Owner?

    static var empty: Repository {
        return Repository(id: nil, name: nil, description: nil, stargazersCount: nil, language: nil, htmlUrl: nil, owner: nil)
    }
}

struct Owner: Decodable, Hashable, Identifiable {
    let id: Int
    let avatarUrl: String
}
