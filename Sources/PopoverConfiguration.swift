//
//  PopoverOption.swift
//  Popover
//
//  Created by archerzz on 2017/5/6.
//
//

import Foundation
import UIKit

/// configuration
public class PopoverConfiguration {
    
    public enum Animation {
        case scale
        case alpha
    }
    
    public static let shared = PopoverConfiguration()
    
    // 默认 (12, 7)
    public var arrowSize = CGSize(width: 12, height: 7)
    
    // 默认 4
    public var cornerRadius = CGFloat(4)
    
    // 默认 0.25
    public var animationDuration = TimeInterval(0.25)
    
    // 默认 white
    public var backgroundColor = UIColor.white
    
    // 默认 UIColor.black.withAlphaComponent(0.35)
    public var dimmingViewColor = UIColor.black.withAlphaComponent(0.35)
    
    // 默认 true
    public var showDimmingView = true
    
    // 默认scale
    public var animation: Animation = .scale
    
    /// 恢复默认设置
    public func restoreDefalut() {
        arrowSize = CGSize(width: 12, height: 7)
        cornerRadius = CGFloat(4)
        animationDuration = TimeInterval(0.25)
        backgroundColor = UIColor.white
        dimmingViewColor = UIColor.black.withAlphaComponent(0.35)
        showDimmingView = true
        animation = .scale
    }
    
}
