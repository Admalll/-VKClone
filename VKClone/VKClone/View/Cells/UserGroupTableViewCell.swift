// UserGroupTableViewCell.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class UserGroupTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet var groupView: AvatarView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Public methods

    func setupCell(name: String, imageName: String) {
        groupNameLabel.text = name
        groupView.setupAvatarImage(imageName: imageName)
    }
}
