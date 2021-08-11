// LoginViewController.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class LoginViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var mainScrollView: UIScrollView!
    @IBOutlet private var progressView: UIView!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        showAnimatingDotsView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        addNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotifications()
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
        return checkLoginInfo()
    }

    // MARK: - Private methods

    private func showAnimatingDotsView() {
        UIView.animate(withDuration: 0.1, delay: 4, animations: {
            self.progressView.alpha = 0.0
        })

        let lay = CAReplicatorLayer()
        lay.frame = CGRect(x: (view.bounds.width - 100) / 2, y: (view.bounds.height - 100) / 2, width: 200, height: 100)
        let circle = CALayer()
        circle.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        circle.cornerRadius = circle.frame.width / 2
        circle.backgroundColor = UIColor.lightGray.cgColor
        lay.addSublayer(circle)
        lay.instanceCount = 3
        lay.instanceTransform = CATransform3DMakeTranslation(45, 0, 0)
        let anim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        anim.fromValue = 1.0
        anim.toValue = 0.2
        anim.duration = 1
        anim.repeatCount = 3

        circle.add(anim, forKey: nil)
        lay.instanceDelay = anim.duration / Double(lay.instanceCount)

        progressView.layer.addSublayer(lay)
    }

    private func checkLoginInfo() -> Bool {
        guard let login = loginTextField.text, let password = passwordTextField.text else { return false }
        if login == "admin", password == "123456" {
            return true
        } else {
            showErrorAlert(alertText: "Ошибка", alertMessage: "Пользователь не найден")
            return false
        }
    }

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

    @objc private func scrollValueChanged(sender: TableScrollCotrol) {
        print(sender.selectedIndex ?? "nil")
    }

    // MARK: - IBActions

    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        guard let login = loginTextField.text, let password = passwordTextField.text else { return }
        login == "admin" && password == "123456" ? print("успешная авторизация") : print("неуспешная авторизация")
    }
}
