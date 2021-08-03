// LoginViewController.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class LoginViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var mainScrollView: UIScrollView!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        addNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotifications()
    }

    // MARK: - Private methods

    private func addNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func removeNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name:
            UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name:
            UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func setupView() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        mainScrollView.addGestureRecognizer(hideKeyboardGesture)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard let info = notification.userInfo as NSDictionary? else { return }
        guard let keyboardSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue
            .size else { return }
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)

        mainScrollView.contentInset = contentInsets
        mainScrollView.scrollIndicatorInsets = contentInsets
    }

    @objc private func keyboardWillHide(notification: Notification) {
        mainScrollView.contentInset = UIEdgeInsets.zero
    }

    @objc private func hideKeyboard() {
        mainScrollView.endEditing(true)
    }

    // MARK: - IBActions

    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        guard let login = loginTextField.text, let password = passwordTextField.text else { return }
        login == "admin" && password == "123456" ? print("успешная авторизация") : print("неуспешная авторизация")
    }
}
