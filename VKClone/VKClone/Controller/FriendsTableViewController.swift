// FriendsTableViewController.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class FriendsTableViewController: UITableViewController {
    // MARK: - Public properties

    var friends: [User] =
        [User(
            userName: "Рустам Рептилоид",
            userAvatarImageName: "reptiloid",
            userPhotosNames: ["reptiloid", "reptiloid"]
        )]

    // MARK: - UITableViewController

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableViewCell") as? FriendsTableViewCell
        else { return UITableViewCell() }
        let friend = friends[indexPath.row]
        cell.setupCell(avatarImageName: friend.userAvatarImageName, nickname: friend.userName)
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showPhotos" else { return }
        guard let vc = segue.destination as? FriendsPhotosCollectionViewController else { return }
        guard let index = tableView.indexPathForSelectedRow?.row else { return }
        vc.setupCells(imageNames: friends[index].userPhotosNames)
        vc.title = friends[index].userName
    }
}
