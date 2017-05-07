//
//  CCPopoverTransitionDelegate.swift
//  CCPopoverViewController
//
//  Created by archerzz on 2017/5/4.
//  Copyright © 2017年 archerzz. All rights reserved.
//

import UIKit


/// PopoverTransitioningDelegate
public final class PopoverTransitioningDelegate: NSObject {

}

// MARK: - UIViewControllerTransitioningDelegate
extension PopoverTransitioningDelegate: UIViewControllerTransitioningDelegate {
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return presented.pop.popoverPresentationController
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CCPopoverAnimatedTransitioning(isPresentation: false)
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CCPopoverAnimatedTransitioning(isPresentation: true)
    }
}


/// 自定义转场动画
final class CCPopoverAnimatedTransitioning: NSObject {
    
    var isPresentation: Bool
    
    fileprivate var popoverPresentationController: PopoverPresentationController?
    
    init(isPresentation: Bool) {
        self.isPresentation = isPresentation
    }
    
}


// MARK: - UIViewControllerAnimatedTransitioning
extension CCPopoverAnimatedTransitioning: UIViewControllerAnimatedTransitioning {
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return PopoverConfiguration.shared.animationDuration
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from), let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        guard let fromView = fromVC.view, let toView = toVC.view else {
            return
        }
        let containerView = transitionContext.containerView
        if isPresentation {
            containerView.addSubview(toView)
        }
        let animatingView = isPresentation ? toView : fromView
        let animatingVC = isPresentation ? toVC : fromVC
        
        if let anchorPoint = animatingVC.pop.popoverPresentationController?.anchorPoint {
            self.popoverPresentationController = animatingVC.pop.popoverPresentationController
            animatingView.pop.resetFrameAfterSet(anchorPoint: anchorPoint)
        }

        let startScale: CGFloat = isPresentation ? 0 : 1
        let endScale: CGFloat = isPresentation ? 1 : 0.1
        let startAlpha: CGFloat = isPresentation ? 0 : 1
        let endAlpha: CGFloat = isPresentation ? 1 : 0.1
        switch PopoverConfiguration.shared.animation {
        case .scale:
            animatingView.transform = CGAffineTransform(scaleX: startScale, y: startScale)
        case .alpha:
            animatingView.alpha = startAlpha
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            switch PopoverConfiguration.shared.animation {
            case .scale:
                if self.isPresentation {
                    animatingView.transform = CGAffineTransform.identity
                } else {
                    animatingView.transform = CGAffineTransform(scaleX: endScale, y: endScale)
                }
            case .alpha:
                animatingView.alpha = endAlpha
            }
        }) { (finished) in
            if !self.isPresentation {
                fromView.removeFromSuperview()
                animatingVC.pop.popoverPresentationController = nil
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        
    }
    
}
