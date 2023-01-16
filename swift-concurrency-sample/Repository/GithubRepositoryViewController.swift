//
//  ViewController.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/04.
//

import UIKit

final class GithubRepositoryViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!

    private let viewModel = MainViewModel()

    /// TODO: CompositonalLayout + CollectionView に変更して、横スクロールにする
    private lazy var collectionViewDataSource = makeDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
        Task {
            await viewModel.fetchRepositories()
        }
    }

    private func setup() {
        collectionView.register(cellType: GithubRepositoryCell.self, bundle: nil)
        collectionView.dataSource = collectionViewDataSource
    }

    /// TODO: Combine使ってやる？？
    private func bind() {
        viewModel.repositories = { [weak self] snapshot in
            self?.collectionViewDataSource.apply(snapshot)
        }
    }

    private func makeDataSource() -> UICollectionViewDiffableDataSource<ProgrammingLanguageSection, ProgrammingLanguageItem> {
        return UICollectionViewDiffableDataSource<ProgrammingLanguageSection, ProgrammingLanguageItem>(collectionView: collectionView) {
            [weak self] (tableView: UICollectionView, indexPath: IndexPath, item: ProgrammingLanguageItem) -> UICollectionViewCell in
            guard let self = self else { return UICollectionViewCell() }
            switch item {
            case .swift(let item):
                let cell = self.collectionView.dequeueReusableCell(with: GithubRepositoryCell.self, for: indexPath)
                cell.setData(item)
                return cell
            case .kotlin(let item):
                let cell = self.collectionView.dequeueReusableCell(with: GithubRepositoryCell.self, for: indexPath)
                cell.setData(item)
                return cell
            case .python(let item):
                let cell = self.collectionView.dequeueReusableCell(with: GithubRepositoryCell.self, for: indexPath)
                cell.setData(item)
                return cell
            case .other(let item):
                let cell = self.collectionView.dequeueReusableCell(with: GithubRepositoryCell.self, for: indexPath)
                cell.setData(item)
                return cell
            }
        }
    }
}
