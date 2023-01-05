//
//  TopSection.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/05.
//

import Foundation

enum SearchSectionHeader {
    case repositories(title: String)
    case users(title: String)
}

enum SearchSectionItem {
    case repositories(item: SearchRepositoryResponse)
    case users(item: SearchUserResponse)
}
