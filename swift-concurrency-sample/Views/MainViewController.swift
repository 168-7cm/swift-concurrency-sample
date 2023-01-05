//
//  ViewController.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/04.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        Task {
            let searchRepositoryRequest = SearchRepositoryRequest(query: "swift")
            let repository = await APIClient.request(searchRepositoryRequest)
            let searchUserRequest = SearchUserRequest(query: "a")
            let user = await APIClient.request(searchUserRequest)
        }
    }

    private func setup() {
        tableView.register(cellType: UITableViewCell.self, bundle: nil)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
