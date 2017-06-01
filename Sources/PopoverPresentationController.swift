//
//  PopoverPresentationController.swift
//  CCPopoverViewController
//
//  Created by archerzz on 2017/5/4.
//  Copyright © 2017年 archerzz. All rights reserved.
//

import UIKit

/// 自定义弹出视图
open class PopoverPresentationController: UIPresentationController {
    
    /// 方向
    public enum ArrowDirection {
        case up
        case left
        case right
        case down
    }
    
    /// 阴影视图
    fileprivate lazy var dimmingView: UIView = { [unowned self] in
        let dimmingView = UIView()
        dimmingView.backgroundColor = PopoverConfiguration.shared.dimmingViewColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped(_:)))
        dimmingView.addGestureRecognizer(tap)
        if !PopoverConfiguration.shared.showDimmingView {
            dimmingView.backgroundColor = UIColor.clear
        }
        return dimmingView
        }()
    
    fileprivate let backgroundView =  PopoverBackgroundView()
    
    fileprivate var backgroundViewRect = CGRect.zero
    
    fileprivate var arrowPoint = CGPoint.zero
    
    /// 指定源视图
    public var sourceView: UIView? {
        didSet {
            assert(barButtonItem == nil, "barButtonItem不能和sourceView一起设置")
        }
    }
    /// 指定源Rect 默认CGRect.zero
    public var sourceRect: CGRect = CGRect.zero
    
    /// 指定barButtonItem
    public var barButtonItem: UIBarButtonItem? {
        didSet {
            assert(sourceView == nil, "barButtonItem不能和sourceView一起设置")
        }
    }
    
    /// 默认为nil，自动计算
    public var arrowPointX: CGFloat? = nil
    /// 默认为nil，自动计算
    public var arrowPointY: CGFloat? = nil
    
    /// 指定间距 默认UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    public var popoverLayoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    /// 默认up
    public var arrowDirection = ArrowDirection.up {
        didSet {
            backgroundView.arrowDirection = arrowDirection
        }
    }
    
    /// 获取anchorPoint
    fileprivate(set) var anchorPoint: CGPoint = CGPoint(x: 0.5, y: 0.5)
    
    
    // MARK: - Override
    // MARK: Properties
    override open var shouldPresentInFullscreen: Bool {
        return true
    }
    
    override open var adaptivePresentationStyle: UIModalPresentationStyle {
        return .overFullScreen
    }
    
    override open var frameOfPresentedViewInContainerView: CGRect {
        var frame = CGRect.zero
        if let containerView = containerView {
            
            var newRect: CGRect
            
            let containerSize = containerView.bounds.size
            frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerSize)
            if let sourceView = sourceView {
                newRect = CGRect(x: sourceRect.origin.x + sourceView.frame.origin.x, y: sourceRect.origin.y + sourceView.frame.origin.y, width: sourceRect.width, height: sourceRect.height)
            } else if let barButtonItem = barButtonItem {
                if let view = barButtonItem.value(forKey: "view") as? UIView {
                    newRect = containerView.convert(view.frame, from: view.superview)
                } else {
                    newRect = CGRect.zero
                }
            } else {
                fatalError("sourceView和barButtonItem必须设置一个")
            }
            
            if let arrowPointX = arrowPointX {
                newRect.origin.x = arrowPointX
                newRect.size.width = 0
            }
            
            if let arrowPointY = arrowPointY {
                newRect.origin.y = arrowPointY
                newRect.size.height = 0
            }
            
            func calculateXWhenArrowDirectionIsUpOrDown() -> CGFloat {
                var x = newRect.midX - frame.midX
                
                if x < 0 {
                    x = popoverLayoutMargins.left
                } else if x > containerSize.width - frame.width {
                    x = containerSize.width - popoverLayoutMargins.right - frame.width
                }
                
                return x
            }
            
            func calculateYWhenArrowDirectionIsLeftOrRight() -> CGFloat {
                var y = newRect.midY - frame.midY
                
                if y < 0 {
                    y = popoverLayoutMargins.top
                } else if y > containerSize.height - frame.height {
                    y = containerSize.height - popoverLayoutMargins.bottom - frame.height
                }
                
                return y
            }
            
            var x: CGFloat = 0
            var y: CGFloat = 0
            let arrowPoint: CGPoint
            let triangleHeight = PopoverConfiguration.shared.arrowSize.height
            let cornerRadius = PopoverConfiguration.shared.cornerRadius
            // 加上幅度的两倍高度以及三角形的高度
            let backgroundViewWidth = frame.width + triangleHeight + cornerRadius * 2
            let backgroundViewHeight = frame.height + triangleHeight
            switch arrowDirection {
            case .up:
                x = calculateXWhenArrowDirectionIsUpOrDown()
                y = newRect.maxY + triangleHeight
                arrowPoint = CGPoint(x: newRect.midX, y: newRect.maxY)
            case .left:
                x = newRect.maxX + triangleHeight + cornerRadius
                y = calculateYWhenArrowDirectionIsLeftOrRight()
                arrowPoint = CGPoint(x: newRect.maxX, y: newRect.midY)
            case .down:
                x = calculateXWhenArrowDirectionIsUpOrDown()
                y = newRect.minY - backgroundViewHeight + cornerRadius
                arrowPoint = CGPoint(x: newRect.midX, y: newRect.minY)
            case .right:
                x = newRect.minX - backgroundViewWidth + cornerRadius
                y = calculateYWhenArrowDirectionIsLeftOrRight()
                arrowPoint = CGPoint(x: newRect.minX, y: newRect.midY)
            }
            
            frame.origin.x = x
            frame.origin.y = y
            
            self.arrowPoint = arrowPoint
            
            switch arrowDirection {
            case .up:
                backgroundViewRect = CGRect(x: x, y: y - triangleHeight , width: frame.width, height: backgroundViewHeight)
            case .down:
                backgroundViewRect = CGRect(x: x, y: y - cornerRadius, width: frame.width, height: backgroundViewHeight)
            case .left:
                backgroundViewRect = CGRect(x: x - triangleHeight - cornerRadius, y: y, width: backgroundViewWidth, height: frame.height)
            case .right:
                backgroundViewRect = CGRect(x: x - cornerRadius, y: y, width: backgroundViewWidth, height: frame.height)
                break
            }
            
            
            
        }
        
        return frame
    }
    
    // MARK: Methods
    
    override open func presentationTransitionWillBegin() {
        guard let containerView = containerView else {
            return
        }
        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0
        containerView.insertSubview(backgroundView, at: 0)
        containerView.insertSubview(dimmingView, at: 0)
        presentedView?.frame = frameOfPresentedViewInContainerView
        backgroundView.frame = backgroundViewRect
        presentedView?.layer.cornerRadius = PopoverConfiguration.shared.cornerRadius
       
        let converArrowPoint = containerView.convert(arrowPoint, to: backgroundView)
        backgroundView.arrawPoint = converArrowPoint
        
        let anchorPoint: CGPoint
        switch arrowDirection {
        case .up:
            anchorPoint = CGPoint(x: converArrowPoint.x / backgroundView.frame.width, y: 0)
        case .down:
            anchorPoint = CGPoint(x: converArrowPoint.x / backgroundView.frame.width, y: 1)
        case .left:
            anchorPoint = CGPoint(x: 0, y: converArrowPoint.y / backgroundView.frame.height)
        case .right:
            anchorPoint = CGPoint(x: 1, y: converArrowPoint.y / backgroundView.frame.height)
        }
        backgroundView.pop.resetFrameAfterSet(anchorPoint: anchorPoint)
        self.anchorPoint = anchorPoint
        switch PopoverConfiguration.shared.animation {
        case .scale:
            backgroundView.transform = CGAffineTransform(scaleX: 0, y: 0)
        case .alpha:
            backgroundView.alpha = 0
        }
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1
            self.backgroundView.transform = CGAffineTransform.identity
            self.backgroundView.alpha = 1
        }, completion: nil)
    }
    
    override open func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        guard let containerView = containerView else {
            return
        }
        dimmingView.frame = containerView.bounds
        presentedView?.frame = frameOfPresentedViewInContainerView
        backgroundView.frame = backgroundViewRect
    }
    
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
            self.presentedView?.frame = self.frameOfPresentedViewInContainerView
            self.backgroundView.frame = self.backgroundViewRect
        }, completion: nil)
    }
    
    open override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
    }
    
    override open func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 0
            switch PopoverConfiguration.shared.animation {
            case .scale:
                self.backgroundView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            case .alpha:
                self.backgroundView.alpha = 0
            }

        }, completion: nil)
    }
    
    override open func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        guard container.preferredContentSize != CGSize.zero else {
            return parentSize
        }
        return container.preferredContentSize
    }
    
}

// MARK: - Actions
private extension PopoverPresentationController {
    
    @objc func dimmingViewTapped(_ gesture: UITapGestureRecognizer) {
        guard gesture.state == .ended else {
            return
        }
        presentingViewController.dismiss(animated: true, completion: nil)
    }
    
}














