// FriendsPhotoCollectionViewCell.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class FriendsPhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var userPhotoImageView: UIImageView!

    // MARK: - Public methods

    func setupCell(imageName: String) {
        userPhotoImageView.image = UIImage(named: imageName)
    }
}
