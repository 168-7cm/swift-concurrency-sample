//
//  GithubSearchResponse.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/05.
//

import UIKit

struct RepositoryResponseEntity: Decodable {
    let totalCount: Int
    let repositories: [RepositoryEntity]

    private enum CodingKeys: String, CodingKey {
        case totalCount
        case repositories = "items"
    }
}

struct RepositoryEntity: Decodable, Hashable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let starCount: Int
    let language: ProgrammingLanguage
    let user: UserEntity

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case starCount = "stargazersCount"
        case language
        case user = "owner"
    }
}
