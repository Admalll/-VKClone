// LikeControl.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class LikeControl: UIControl {
    // MARK: - Visual components

    private let likeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        button.frame = CGRect(x: 20, y: 0, width: 20, height: 20)
        button.addTarget(self, action: #selector(likeButtonTap(sender:)), for: .touchUpInside)
        return button
    }()

    private let likesCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.backgroundColor = .clear
        label.textColor = .systemBlue
        label.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
        return label
    }()

    // MARK: - Private properties

    private var likesCount = 0 {
        didSet {
            UIView.transition(
                with: likesCountLabel,
                duration: 0.5,
                options: .transitionFlipFromLeft,
                animations: {
                    self.likesCountLabel.text = String(self.likesCount)
                },
                completion: nil
            )
        }
    }

    private var isLike = false

    // MARK: - Initializators

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(likeButton)
        addSubview(likesCountLabel)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(likeButton)
        addSubview(likesCountLabel)
    }

    // MARK: - Private methods

    @objc private func likeButtonTap(sender: UIButton) {
        if sender == likeButton {
            isLike.toggle()
            isLike ? likePhoto() : unlikePhoto()
        }
    }

    private func likePhoto() {
        likeButton.setImage(
            UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal),
            for: .normal
        )
        likesCountLabel.textColor = .red
        likesCount += 1
    }

    private func unlikePhoto() {
        likeButton.setImage(
            UIImage(systemName: "heart")?.withTintColor(.black, renderingMode: .alwaysOriginal),
            for: .normal
        )
        likesCountLabel.textColor = .blue
        likesCount -= 1
    }
}
