// FriendsViewController.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class FriendsViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var tableScrollControl: TableScrollCotrol!

    // MARK: - Visual components

    private let resultSearchController = UISearchController()

    // MARK: - Private properties

    private var filteredFriends: [UserWithLetter] = []
    private var unsortedFriends: [UserWithLetter] = [
        UserWithLetter(
            letter: "R",
            users: [
                User(
                    userName: "Rustam Reptiloid",
                    userAvatarImageName: "kek",
                    userPhotosNames: ["reptiloid-1", "rust"]
                ),
                User(userName: "Rustam NeReptiloid", userAvatarImageName: "rust", userPhotosNames: ["kek", "rust"]),
                User(
                    userName: "Rustam Reptiloid",
                    userAvatarImageName: "kek",
                    userPhotosNames: ["reptiloid-1", "rust"]
                ),
                User(userName: "Rustam NeReptiloid", userAvatarImageName: "rust", userPhotosNames: ["kek", "rust"])
            ]
        ),
        UserWithLetter(
            letter: "T",
            users: [
                User(userName: "Tambi", userAvatarImageName: "tambi1", userPhotosNames: ["tambi2", "tambi3"]),
                User(userName: "Tambi", userAvatarImageName: "tambi1", userPhotosNames: ["tambi2", "tambi3"]),
                User(userName: "Tambi", userAvatarImageName: "tambi1", userPhotosNames: ["tambi2", "tambi3"]),
                User(userName: "Tambi", userAvatarImageName: "tambi1", userPhotosNames: ["tambi2", "tambi3"])
            ]
        ),
        UserWithLetter(
            letter: "D",
            users: [
                User(userName: "Dambi", userAvatarImageName: "tambi1", userPhotosNames: ["tambi2", "tambi3"]),
                User(userName: "Dolbik", userAvatarImageName: "jeegun2", userPhotosNames: ["jeegun1", "jeegun2"]),
                User(userName: "Dambi", userAvatarImageName: "tambi1", userPhotosNames: ["tambi2", "tambi3"]),
                User(userName: "Dolbik", userAvatarImageName: "jeegun2", userPhotosNames: ["jeegun1", "jeegun2"]),
            ]
        ),
        UserWithLetter(
            letter: "N",
            users: [User(
                userName: "Nursultan",
                userAvatarImageName: "nursultan1",
                userPhotosNames: ["nursultan2", "nursultan3"]
            ), User(
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
            ), User(userName: "Bio", userAvatarImageName: "jeegun3", userPhotosNames: ["jeegun1", "jeegun2"]), User(
                userName: "Bursultan",
                userAvatarImageName: "nursultan1",
                userPhotosNames: ["nursultan2", "nursultan3"]
            ), User(userName: "Bio", userAvatarImageName: "jeegun3", userPhotosNames: ["jeegun1", "jeegun2"])]
        ), UserWithLetter(
            letter: "A",
            users: [
                User(userName: "Amir", userAvatarImageName: "amir1", userPhotosNames: ["amir2", "amir3"]),
                User(userName: "Amir", userAvatarImageName: "amir1", userPhotosNames: ["amir2", "amir3"])
            ]
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

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showPhotos" else { return }
        guard let vc = segue.destination as? FriendsPhotosCollectionViewController else { return }
        guard let index = tableView.indexPathForSelectedRow else { return }
        vc.setupCells(imageNames: friends[index.section].users[index.row].userPhotosNames)
        vc.title = friends[index.section].users[index.row].userName
    }

    // MARK: - Private methods

    private func setupView() {
        setupScroll()
        setupSearchController()
    }

    private func setupSearchController() {
        resultSearchController.searchResultsUpdater = self
        resultSearchController.searchBar.sizeToFit()
        tableView.tableHeaderView = resultSearchController.searchBar
        tableView.reloadData()
    }

    private func setupScroll() {
        var letters: [Character] = []
        friends.forEach { letters.append($0.letter) }
        tableScrollControl.setupLetters(letters: letters)

        tableScrollControl.addTarget(self, action: #selector(selectedLetterChanged), for: .valueChanged)
    }

    @objc private func selectedLetterChanged(sender: TableScrollCotrol) {
        guard let section = sender.selectedIndex else { return }
        let indexPath = IndexPath(row: 0, section: section)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

// MARK: - Table view data source

extension FriendsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        resultSearchController.isActive ? filteredFriends.count : friends.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resultSearchController.isActive ? filteredFriends[section].users.count : friends[section].users.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(friends[section].letter)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableViewCell") as? FriendsTableViewCell
        else { return UITableViewCell() }
        if resultSearchController.isActive {
            let friend = filteredFriends[indexPath.section].users[indexPath.row]
            cell.setupCell(avatarImageName: friend.userAvatarImageName, nickname: friend.userName)
            return cell
        } else {
            let friend = friends[indexPath.section].users[indexPath.row]
            cell.setupCell(avatarImageName: friend.userAvatarImageName, nickname: friend.userName)
            return cell
        }
    }
}

extension FriendsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredFriends.removeAll(keepingCapacity: false)
        guard let text = searchController.searchBar.text else { return }
        let array = friends.filter { String($0.letter) == text }
        filteredFriends = array
        tableView.reloadData()
    }
}
