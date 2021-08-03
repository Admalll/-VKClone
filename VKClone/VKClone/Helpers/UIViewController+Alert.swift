// UIViewController+Alert.swift
// Copyright © Roadmap. All rights reserved.

import UIKit
extension UIViewController {
    func showErrorAlert(alertText: String, alertMessage: String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel))
        present(alert, animated: true)
    }
}
