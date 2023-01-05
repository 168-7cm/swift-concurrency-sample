//
//  GithubSearchResponse.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/05.
//

import UIKit

struct SearchRepositoryResponse: Decodable {
    let totalCount: Int
    let items: [Repository]
}

struct Repository: Decodable, Hashable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let stargazersCount: Int
    let language: String
    let htmlUrl: String
    let owner: Owner
}

struct Owner: Decodable, Hashable, Identifiable {
    let id: Int
    let avatarUrl: String
}
