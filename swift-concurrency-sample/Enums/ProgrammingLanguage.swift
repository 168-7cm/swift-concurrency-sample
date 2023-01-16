//
//  ProgrammingLanguage.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/16.
//

import Foundation

enum ProgrammingLanguage: String, Decodable, CaseIterable {
    case swift
    case kotlin
    case python
    case other

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

extension ProgrammingLanguage {
    var displayText: String {
        return rawValue.capitalized
    }
}
