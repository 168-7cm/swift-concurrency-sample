//
//  ViewController.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/04.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    private lazy var tableViewDataSource: UITableViewDiffableDataSource<SearchSectionHeader, SearchSectionItem> = .init(tableView: tableView) {
        (tableView: UITableView, indexPath: IndexPath, item: SearchSectionItem) -> UITableViewCell in
        switch item {
        case .repositories(let item):
            return UITableViewCell()
        case .users(let item):
            return UITableViewCell()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        update()
    }

    private func setup() {
        tableView.register(cellType: UITableViewCell.self, bundle: nil)
        tableView.delegate = self
        tableView.dataSource = tableViewDataSource
    }

    private func update() {
        var snapshot = NSDiffableDataSourceSnapshot<SearchSectionHeader, SearchSectionItem>()
        snapshot.appendSections([.repositories(title: "レポジトリ"), .users(title: "ユーザー")])
        snapshot.appendItems([.repositories(item: .empty)], toSection: .repositories(title: "レポジトリ"))
        snapshot.appendItems([.users(item: .empty)], toSection: .users(title: "ユーザー"))
        tableViewDataSource.apply(snapshot)
    }
}

extension MainViewController: UITableViewDelegate {}
