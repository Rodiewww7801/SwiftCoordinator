//
//  SlideTransition.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 06.09.2024.
//

import UIKit



class SlideTransition: NSObject, UIViewControllerAnimatedTransitioning {
    enum Animation {
        case presenting
        case dismissing
    }
    
    var animationFor: Animation
    
    init(for animationFor: Animation) {
        self.animationFor = animationFor
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let isPresenting = animationFor == .presenting
        let key = isPresenting ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        guard let controller = transitionContext.viewController(forKey: key) else { return }
        
        let containerView = transitionContext.containerView
        
        if isPresenting {
            containerView.addSubview(controller.view)
        }
        
        let finalFrame = transitionContext.finalFrame(for: controller)
        let startingFrame = isPresenting ? finalFrame.offsetBy(dx: 0, dy: finalFrame.height) : finalFrame
        let endingFrame = isPresenting ? finalFrame : finalFrame.offsetBy(dx: 0, dy: finalFrame.height)
        
        controller.view.frame = startingFrame
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            controller.view.frame = endingFrame
        }, completion: { _ in
            let wasCancelled = transitionContext.transitionWasCancelled
            if !isPresenting && wasCancelled {
                // Dismissal cancelled, need to add the view back
                controller.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!wasCancelled)
        })
    }
}

final class SlideTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideTransition(for: .presenting)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideTransition(for: .dismissing)
    }
}

