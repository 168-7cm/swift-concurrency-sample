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
    private lazy var layout = makeCompositionalLayout()

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
        collectionView.collectionViewLayout = layout
    }

    /// TODO: Combine使ってやる？？
    private func bind() {
        viewModel.repositories = { [weak self] snapshot in
            self?.collectionViewDataSource.apply(snapshot)
        }
    }

    /// TODO: 他のセクションの追加 + ヘッダーフッダーの追加
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

    /// 最低限のCompositionalLayoutを作成する
    /// TODO: ヘッダーの付与、他セクションの追加、ページング時のローディング
    /// CompositionalLayout で Self-Sizing するには、item と group のどちらも .estimated にする必要がある
    /// ref: https://medium.com/swiftblade/dynamic-cell-height-in-uicollectionviewcompositionallayout-9b46d2032890
    private func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in

            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .estimated(100))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            /// AutoLayoutを優先させたいため、.estimated(100)で設定する
            let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .estimated(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
        return layout
    }
}
