//
//  TopSection.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/05.
//

import Foundation

enum ProgrammingLanguageSection: CaseIterable {
    case swift
    case kotlin
    case python
    case other
}

enum ProgrammingLanguageItem: Hashable {
    case swift(items: RepositoryEntity)
    case kotlin(items: RepositoryEntity)
    case python(items: RepositoryEntity)
    case other(items: RepositoryEntity)
}

enum Header: Hashable {
    case repositories(title: String)
    case users(title: String)
}

enum Section: CaseIterable {
    case repository
}

enum Item: Hashable {
    case repository(items: RepositoryEntity)

//    static func == (lhs: Item, rhs: Item) -> Bool {
//        return lhs.hashValue == rhs.hashValue
//    }
//
//    func hash(into hasher: inout Hasher) {
//        switch self {
//        case let .repository(item):
//            hasher.combine(item.id)
//        }
//    }
}
