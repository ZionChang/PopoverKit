//
//  PopoverCompatible.swift
//  CCPopoverViewController
//
//  Created by archerzz on 2017/5/4.
//  Copyright © 2017年 archerzz. All rights reserved.
//

import Foundation
import UIKit


/// Popover
public final class Popover<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

/**
 A type that has PopPrefix extensions.
 */
public protocol PopoverCompatible {
    associatedtype PopoverCompatibleType
    var pop: PopoverCompatibleType { get }
}

// MARK: - PopoverCompatible
public extension PopoverCompatible {
    public var pop: Popover<Self> {
        get { return Popover(self) }
    }

}


// MARK: - UIViewController
extension UIViewController: PopoverCompatible {}

// MARK: - UIView
extension UIView: PopoverCompatible {}
