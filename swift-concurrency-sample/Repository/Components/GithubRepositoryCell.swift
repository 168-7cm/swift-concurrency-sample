//
//  GithubRepositoryCell.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/16.
//

import UIKit

final class GithubRepositoryCell: UICollectionViewCell {
    @IBOutlet private weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        customInit()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        customInit()
    }

    private func customInit() {
        nameLabel.text = ""
    }

    func setData(_ repository: RepositoryEntity) {
        nameLabel.text = repository.name
    }
}
