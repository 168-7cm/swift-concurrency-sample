//
//  GithubSearchResponse.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/05.
//

import UIKit

enum Language: String, Decodable, CaseIterable {
    case swift
    case kotlin
    case python
    case other

    var displayText: String {
        return self.rawValue.capitalized
    }

    /// プログラミング言語を全て列挙したらキリがないので、4つほどにする
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        switch value {
        case "Swift":
            self = .swift
        case "Kotin":
            self = .kotlin
        case "Python":
            self = .python
        default:
            self = .other
        }
    }
}

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
    let language: Language
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
