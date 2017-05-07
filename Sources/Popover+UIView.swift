//
//  Popover+UIView.swift
//  CCPopoverViewController
//
//  Created by archerzz on 2017/5/5.
//  Copyright © 2017年 archerzz. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIView
extension Popover where Base: UIView {
    
    /// 设置anchorPoint之后重新设置frame
    func resetFrameAfterSet(anchorPoint: CGPoint) {
        
        let oldFrame = base.frame
        base.layer.anchorPoint = anchorPoint
        base.frame = oldFrame
        
    }
    
}
