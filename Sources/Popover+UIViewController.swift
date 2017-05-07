//
//  Popover+UIViewController.swift
//  CCPopoverViewController
//
//  Created by archerzz on 2017/5/5.
//  Copyright © 2017年 archerzz. All rights reserved.
//

import Foundation
import UIKit

/// keys
private var popoverPresentationControllerKey: UInt8 = 0
private var transitioningDelegateKey: UInt8 = 0
private var isNeedPopoverKey: UInt8 = 0

// MARK: - UIViewController
extension Popover where Base: UIViewController {
    
    /// 是否开启Popover模式
    public var isNeedPopover: Bool {
        set {
            objc_setAssociatedObject(base, &isNeedPopoverKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            if newValue {
                base.modalPresentationStyle = .custom
                base.transitioningDelegate = base.pop.transitioningDelegate
            } else {
                base.modalPresentationStyle = .none
                base.transitioningDelegate = nil
            }
        } get {
            return (objc_getAssociatedObject(base, &isNeedPopoverKey) as? Bool) ?? false
        }
    }
    
    /// 一旦调用就初始化并且关联一个PopoverPresentationController
    public var popoverPresentationController: PopoverPresentationController? {
        set {
            objc_setAssociatedObject(base, &popoverPresentationControllerKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let popover = objc_getAssociatedObject(base, &popoverPresentationControllerKey) as? PopoverPresentationController {
                return popover
            }
            let popover = PopoverPresentationController(presentedViewController: base, presenting: nil)
            objc_setAssociatedObject(base, &popoverPresentationControllerKey, popover, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return popover
        }
    }
    
    /// 一旦调用就初始化并且关联一个PopoverTransitioningDelegate
    public var transitioningDelegate: PopoverTransitioningDelegate {
        if let transitioningDelegate = objc_getAssociatedObject(base, &transitioningDelegateKey) as? PopoverTransitioningDelegate {
            return transitioningDelegate
        }
        let transitioningDelegate = PopoverTransitioningDelegate()
        objc_setAssociatedObject(base, &transitioningDelegateKey, transitioningDelegate, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return transitioningDelegate
    }
    
}
