// NewsViewController.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class NewsViewController: UIViewController {}

// MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") else { return UITableViewCell() }
        return cell
    }
}
