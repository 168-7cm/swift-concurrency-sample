//
//  SearchUserResponse.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/05.
//

import UIKit

struct UserResponseEntity: Decodable {
    let totalCount: Int
    let users: [UserEntity]

    private enum CodingKeys: String, CodingKey {
        case totalCount
        case users = "items"
    }
}

struct UserEntity: Decodable, Hashable, Identifiable {
    let id: Int
    let name: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name = "login"
    }
}
