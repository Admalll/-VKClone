// FriendsTableViewController.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class FriendsTableViewController: UITableViewController {
    // MARK: - Public properties

    private var unsortedFriends: [UserWithLetter] = [
        UserWithLetter(
            letter: "R",
            users: [User(
                userName: "Rustam Reptiloid",
                userAvatarImageName: "kek",
                userPhotosNames: ["reptiloid-1", "rust"]
            ), User(userName: "Rustam NeReptiloid", userAvatarImageName: "rust", userPhotosNames: ["kek", "rust"])]
        ),
        UserWithLetter(
            letter: "T",
            users: [User(userName: "Tambi", userAvatarImageName: "tambi1", userPhotosNames: ["tambi2", "tambi3"])]
        ),
        UserWithLetter(
            letter: "D",
            users: [
                User(userName: "Dambi", userAvatarImageName: "tambi1", userPhotosNames: ["tambi2", "tambi3"]),
                User(userName: "Dolbik", userAvatarImageName: "jeegun2", userPhotosNames: ["jeegun1", "jeegun2"])
            ]
        ),
        UserWithLetter(
            letter: "N",
            users: [User(
                userName: "Nursultan",
                userAvatarImageName: "nursultan1",
                userPhotosNames: ["nursultan2", "nursultan3"]
            )]
        ),
        UserWithLetter(
            letter: "B",
            users: [User(
                userName: "Bursultan",
                userAvatarImageName: "nursultan1",
                userPhotosNames: ["nursultan2", "nursultan3"]
            ), User(userName: "Bio", userAvatarImageName: "jeegun3", userPhotosNames: ["jeegun1", "jeegun2"])]
        ), UserWithLetter(
            letter: "A",
            users: [User(userName: "Amir", userAvatarImageName: "amir1", userPhotosNames: ["amir2", "amir3"])]
        ), UserWithLetter(
            letter: "E",
            users: [User(userName: "Emir", userAvatarImageName: "amir1", userPhotosNames: ["amir2", "amir3"])]
        ), UserWithLetter(
            letter: "G",
            users: [
                User(userName: "Grigory Leps", userAvatarImageName: "leps1", userPhotosNames: ["leps2", "leps3"]),
                User(userName: "Grigory Leps2", userAvatarImageName: "leps2", userPhotosNames: ["leps2", "leps1"]),
                User(userName: "Grigory Leps3", userAvatarImageName: "leps3", userPhotosNames: ["leps1", "leps3"])
            ]
        ), UserWithLetter(
            letter: "J",
            users: [User(userName: "Jeegun", userAvatarImageName: "jeegun1", userPhotosNames: ["jeegun1", "jeegun2"])]
        )
    ]

    private var friends: [UserWithLetter] {
        unsortedFriends.sorted { $0.letter < $1.letter }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        friends.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends[section].users.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(friends[section].letter)
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var array: [String] = []
        for friend in friends {
            array += [String(friend.letter)]
        }
        return array
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableViewCell") as? FriendsTableViewCell
        else { return UITableViewCell() }
        let friend = friends[indexPath.section].users[indexPath.row]
        cell.setupCell(avatarImageName: friend.userAvatarImageName, nickname: friend.userName)
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showPhotos" else { return }
        guard let vc = segue.destination as? FriendsPhotosCollectionViewController else { return }
        guard let index = tableView.indexPathForSelectedRow else { return }
        vc.setupCells(imageNames: friends[index.section].users[index.row].userPhotosNames)
        vc.title = friends[index.section].users[index.row].userName
    }
}
