//
//  MainViewModel.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/04.
//

import UIKit

@MainActor
final class MainViewModel {
    var repositories: (NSDiffableDataSourceSnapshot<SearchSectionHeader, SearchSectionItem>) -> Void = { _ in }
    var users: (NSDiffableDataSourceSnapshot<SearchSectionHeader, SearchSectionItem>) -> Void = { _ in }
    var showError: (ApiError) ->  Void = { _ in }

    nonisolated func fetchRepositories() async {
        do {
            let request = SearchRepositoryRequest(query: "swift")
            let repositories = try await APIClient.shared.request(request)
            let snapshot = makeSnapshot(repositories: repositories.repositories)
            await self.repositories(snapshot)
        } catch {}
    }

    nonisolated private func makeSnapshot(repositories: [RepositoryEntity]) -> NSDiffableDataSourceSnapshot<SearchSectionHeader, SearchSectionItem> {
        let items = repositories.map { SearchSectionItem.repositories(item: $0) }
        var snapshot = NSDiffableDataSourceSnapshot<SearchSectionHeader, SearchSectionItem>()
        snapshot.appendSections([.repositories(title: "レポジトリ")])
        snapshot.appendItems(items)
        return snapshot
    }
}
