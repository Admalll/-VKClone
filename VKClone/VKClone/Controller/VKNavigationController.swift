// VKNavigationController.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class VKNavigationController: UINavigationController {
    let interactiveTransition = VKPercentDrivenInteractiveTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension VKNavigationController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? { interactiveTransition.hasStarted ? interactiveTransition : nil }

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            interactiveTransition.viewController = toVC
            return VKPushAnimator(isPush: true)
        case .pop:
            if navigationController.viewControllers.first != toVC {
                interactiveTransition.viewController = toVC
            }
            return VKPopAnimator()
        default: return nil
        }
    }
}
