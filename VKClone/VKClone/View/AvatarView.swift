// AvatarView.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

@IBDesignable final class AvatarView: UIView {
    // MARK: - Private properties

    @IBInspectable private var shadowOpacity: Float = 1 {
        didSet {
            updateShadows()
        }
    }

    @IBInspectable private var shadowColor: UIColor = .black {
        didSet {
            updateShadows()
        }
    }

    @IBInspectable private var shadowRadius: CGFloat = 1 {
        didSet {
            updateShadows()
        }
    }

    @IBInspectable private var shadowSize: CGSize = .init(width: 1, height: 1) {
        didSet {
            updateShadows()
        }
    }

    private var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private var avaratarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "reptiloid")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    // MARK: - Initializators

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }

    // MARK: - UIView

    override func layoutSubviews() {
        super.layoutSubviews()
        setupViewsFrames()
    }

    // MARK: - Public methods

    func setupAvatarImage(imageName: String) {
        avaratarImageView.image = UIImage(named: imageName)
    }

    // MARK: - Private methods

    private func setupSubviews() {
        addSubview(shadowView)
        addSubview(avaratarImageView)
        setupAnimation()
    }

    private func updateShadows() {
        shadowView.layer.shadowOpacity = shadowOpacity
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowRadius = shadowRadius
        shadowView.layer.shadowOffset = shadowSize
    }

    private func setupViewsFrames() {
        shadowView.frame = bounds
        shadowView.layer.cornerRadius = bounds.width / 2
        avaratarImageView.frame = bounds
        avaratarImageView.layer.cornerRadius = bounds.width / 2
    }

    private func setupAnimation() {
        avaratarImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped(sender:)))
        avaratarImageView.addGestureRecognizer(tapGesture)
    }

    @objc private func avatarTapped(sender: UIImageView) {
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: []
        ) {
            self.avaratarImageView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        } completion: { _ in
            UIView.animate(
                withDuration: 1,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: []
            ) {
                self.avaratarImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}
