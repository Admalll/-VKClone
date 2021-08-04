// UserGroupsTableViewController.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class UserGroupsTableViewController: UITableViewController {
    // MARK: - Private properties

    private var groups: [Group] = [Group(groupName: "reptiloid", groupImageName: "reptiloid")]

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: "UserGroupTableViewCell") as? UserGroupTableViewCell
        else { return UITableViewCell() }
        let group = groups[indexPath.row]
        cell.setupCell(name: group.groupName, imageName: group.groupImageName)
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - IBActionn

    @IBAction func addGroup(seague: UIStoryboardSegue) {
        if seague.identifier == "addGroup" {
            guard let vc = seague.source as? AllGroupsTableViewController else { return }
            guard let indexPath = vc.tableView.indexPathForSelectedRow else { return }
            let group = vc.returnGroupInfo(indexPath: indexPath)
            groups += [group]
            tableView.reloadData()
        }
    }
}
