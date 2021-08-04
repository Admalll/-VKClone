// AllGroupsTableViewController.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class AllGroupsTableViewController: UITableViewController {
    // MARK: - Priva properties

    private var groups: [Group] = [
        Group(groupName: "reptiloid2", groupImageName: "reptiloid"),
        Group(groupName: "reptiloid3", groupImageName: "reptiloid")
    ]

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: "AllGroupsTableViewCell") as? AllGroupsTableViewCell
        else { return UITableViewCell() }
        let group = groups[indexPath.row]
        cell.setupCell(groupName: group.groupName, groupImageName: group.groupImageName)
        return cell
    }

    // MARK: - Public methods

    func returnGroupInfo(indexPath: IndexPath) -> Group {
        groups.remove(at: indexPath.row)
    }
}
