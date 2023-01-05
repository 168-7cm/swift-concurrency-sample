//
//  SearchUserResponse.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/05.
//

import UIKit

struct SearchUserResponse: Decodable {
    let totalCount: Int
    let items: [User]
}


struct User: Decodable, Hashable, Identifiable {
    let login: String
    let id: Int
    let avatarUrl: String
}
