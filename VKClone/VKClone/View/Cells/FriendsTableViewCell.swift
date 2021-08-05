// FriendsTableViewCell.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class FriendsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nicknameLabel: UILabel!

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Public methods

    func setupCell(avatarImageName: String, nickname: String) {
        avatarImageView.image = UIImage(named: avatarImageName)
        nicknameLabel.text = nickname
    }
}