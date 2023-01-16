//
//  ProgrammingLanguageSection.swift
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
