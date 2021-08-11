// FriendsPhotosCollectionViewController.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class FriendsPhotosCollectionViewController: UICollectionViewController {
    enum Const {
        static let reuseIdentifier = "FriendsPhotoCollectionViewCell"
    }

    // MARK: - Private properties

    private var userPhotosNames: [String] = []

    // MARK: - UICollectionViewController

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userPhotosNames.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Const.reuseIdentifier,
            for: indexPath
        ) as? FriendsPhotoCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(imageName: userPhotosNames[indexPath.row])

        // Configure the cell

        return cell
    }

    // MARK: - Public methods

    func setupCells(imageNames: [String]) {
        userPhotosNames = imageNames
    }
}
