//
//  MainViewModel.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/04.
//

import UIKit

@MainActor
final class MainViewModel {
    /// TODO: typealiasの設定
    var repositories: (NSDiffableDataSourceSnapshot<ProgrammingLanguageSection, ProgrammingLanguageItem>) -> Void = { _ in }
    var showError: (ApiError) ->  Void = { _ in }

    nonisolated func fetchRepositories() async {
        do {
            let request = SearchRepositoryRequest(query: "swift")
            let repositories = try await APIClient.shared.request(request)
            let snapshot = makeSnapshot(repositories: repositories.repositories)
            await self.repositories(snapshot)
        } catch {
            print(error)
        }
    }

    /// TODO: もっと綺麗に書ける
    nonisolated private func makeSnapshot(repositories: [RepositoryEntity]) -> NSDiffableDataSourceSnapshot<ProgrammingLanguageSection, ProgrammingLanguageItem> {
        var snapshot = NSDiffableDataSourceSnapshot<ProgrammingLanguageSection, ProgrammingLanguageItem>()
        snapshot.appendSections(ProgrammingLanguageSection.allCases)
        let swiftItems: [ProgrammingLanguageItem] = repositories.filter { $0.language == .swift }.map { .swift(items: $0) }
        let otherItems: [ProgrammingLanguageItem] = repositories.filter { $0.language == .other }.map { .other(items: $0) }
        snapshot.appendItems(swiftItems, toSection: .swift)
        snapshot.appendItems(otherItems, toSection: .other)
        return snapshot
    }
}
