//
//  ViewController.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/04.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = MainViewModel()

    private lazy var tableViewDataSource: UITableViewDiffableDataSource<SearchSectionHeader, SearchSectionItem> = .init(tableView: tableView) {
        (tableView: UITableView, indexPath: IndexPath, item: SearchSectionItem) -> UITableViewCell in
        switch item {
        case .repositories(let item):
            let cell = UITableViewCell()
            cell.textLabel?.text = item.name
            return cell
        case .users(let item):
            return UITableViewCell()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
        Task {
            await viewModel.fetchRepositories()
        }
    }

    private func setup() {
        tableView.register(cellType: UITableViewCell.self, bundle: nil)
        tableView.dataSource = tableViewDataSource
    }

    private func bind() {
        viewModel.repositories = { [weak self] snapshot in
            self?.tableViewDataSource.apply(snapshot)
        }
    }
}
