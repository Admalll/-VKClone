// VKPushAnimator.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class VKPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Private Properties

    private var destinationRotateAngle: CGFloat
    private var destinationTranslationX: CGFloat

    // MARK: - Initializators

    init(isPush: Bool) {
        if isPush {
            destinationRotateAngle = -.pi / 2
            destinationTranslationX = UIScreen.main.bounds.width
        } else {
            destinationRotateAngle = .pi / 2
            destinationTranslationX = -UIScreen.main.bounds.width
        }
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.7
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }

        let sourceViewFrame = source.view.frame

        let destinationRotate = CGAffineTransform(rotationAngle: destinationRotateAngle)
        let sourseRotate = CGAffineTransform(rotationAngle: -destinationRotateAngle)
        let destinationTranslation = CGAffineTransform(
            translationX: destinationTranslationX,
            y: -sourceViewFrame.height / 2
        )
        let sourseTranslation = CGAffineTransform(
            translationX: -destinationTranslationX,
            y: -sourceViewFrame.height / 2
        )

        destination.view.frame = sourceViewFrame
        destination.view.transform = destinationRotate.concatenating(destinationTranslation)
        transitionContext.containerView.addSubview(destination.view)

        UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext), delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                destination.view.transform = .identity
                destination.view.frame = sourceViewFrame
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                source.view.transform = sourseRotate.concatenating(sourseTranslation)
            }
        } completion: { finished in
            source.view.transform = .identity
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
