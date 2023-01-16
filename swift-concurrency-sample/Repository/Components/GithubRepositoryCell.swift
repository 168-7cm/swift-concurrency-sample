//
//  GithubRepositoryCell.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/16.
//

import UIKit

final class GithubRepositoryCell: UICollectionViewCell {
    @IBOutlet private weak var userProfileImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var starCountLabel: UILabel!
    @IBOutlet private weak var programmingLanguageColorImageView: UIImageView!
    @IBOutlet private weak var programmingLanguageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        customInit()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        customInit()
    }

    private func customInit() {
        userProfileImageView.image = nil
        userNameLabel.text = ""
        nameLabel.text = ""
        starCountLabel.text = ""
        programmingLanguageColorImageView.layer.cornerRadius = programmingLanguageColorImageView.frame.width / 2
        programmingLanguageColorImageView.image = nil
        programmingLanguageLabel.text = ""
    }

    /// TODO: 画像のキャッシュ
    func setData(_ repository: RepositoryEntity) {
       // userProfileImageView.image = repository.user.
        userNameLabel.text = repository.user.name
        nameLabel.text = repository.name
        starCountLabel.text = "\(repository.starCount)"
        programmingLanguageColorImageView.backgroundColor = repository.programmingLanguage.backgroundColor
        programmingLanguageLabel.text = repository.programmingLanguage.displayText
    }
}
