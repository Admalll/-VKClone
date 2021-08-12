// DetailsPhotoViewController.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class DetailsPhotoViewController: UIViewController {
    // MARK: - IBOUtlet

    @IBOutlet var photoImageView: UIImageView!

    // MARK: - Private properties

    private let photos = [UIImage(named: "amir1"), UIImage(named: "amir2"), UIImage(named: "amir3")]
    private var index = 0 {
        didSet {
            photoImageView.image = photos[index]
        }
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSwipes()
    }

    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                if index == photos.count - 1 {
                    index = 0
                } else {
                    index += 1
                }
                swipeLeft()

            case UISwipeGestureRecognizer.Direction.right:
                if index == 0 {
                    index = photos.count - 1
                } else {
                    index -= 1
                }
                swipeRight()

            default:
                break
            }
        }
    }

    // MARK: - Private methods

    private func setupSwipes() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        view.addGestureRecognizer(swipeLeft)
    }

    private func swipeLeft() {
        UIView.animateKeyframes(
            withDuration: 0.8,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                    self.photoImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                }

                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 1,
                    animations: {
                        let animation = CABasicAnimation(keyPath: "position.x")
                        animation.fromValue = self.photoImageView.layer.bounds.origin
                            .x + 800
                        animation.toValue = self.photoImageView.layer.bounds.origin.x
                        animation.duration = 1
                        self.photoImageView.layer.add(animation, forKey: nil)
                    }
                )
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                    self.photoImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            }
        )
    }

    private func swipeRight() {
        UIView.animateKeyframes(
            withDuration: 1,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                    self.photoImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                }

                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 1,
                    animations: {
                        let animation = CABasicAnimation(keyPath: "position.x")
                        animation.fromValue = self.photoImageView.layer.bounds.origin.x - 800
                        animation.toValue = self.photoImageView.layer.bounds.origin.x
                        animation.duration = 1
                        self.photoImageView.layer.add(animation, forKey: nil)
                    }
                )

                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                    self.photoImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            }
        )
    }
}
