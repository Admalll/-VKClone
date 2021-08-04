// AllGroupsTableViewCell.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class AllGroupsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Public methods

    func setupCell(groupName: String, groupImageName: String) {
        groupNameLabel.text = groupName
        groupImageView.image = UIImage(named: groupImageName)
    }
}
