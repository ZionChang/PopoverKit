//
//  PopoverBackgroundView.swift
//  CCPopoverViewController
//
//  Created by archerzz on 2017/5/4.
//  Copyright © 2017年 archerzz. All rights reserved.
//

import UIKit

/// PopoverBackgroundView
class PopoverBackgroundView: UIView {
    
    /// 箭头起始点
    var arrawPoint: CGPoint = CGPoint.zero
    /// 箭头方向
    var arrowDirection: PopoverPresentationController.ArrowDirection = .up
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        let fillColor = PopoverConfiguration.shared.backgroundColor
        
        context?.saveGState()
        context?.beginTransparencyLayer(auxiliaryInfo: nil)
        
        //// Rectangle-670 Drawing
        let rectangle670Path = UIBezierPath()
        
        let startX: CGFloat = arrawPoint.x
        let startY: CGFloat = arrawPoint.y
        let triangleHeight = PopoverConfiguration.shared.arrowSize.height
        let triangleWidth = PopoverConfiguration.shared.arrowSize.width
        let halfWidth = triangleWidth / 2
        
        switch arrowDirection {
        case .up:
            let triangleStartY: CGFloat = 0
            rectangle670Path.move(to: CGPoint(x: startX, y: triangleStartY))
            rectangle670Path.addLine(to: CGPoint(x: startX + halfWidth, y: triangleStartY + triangleHeight))
            rectangle670Path.addLine(to: CGPoint(x: startX - halfWidth, y: triangleStartY + triangleHeight))
        case .down:
            let triangleStartY = rect.height - triangleHeight
            rectangle670Path.move(to: CGPoint(x: startX, y: rect.height))
            rectangle670Path.addLine(to: CGPoint(x: startX + halfWidth, y: triangleStartY))
            rectangle670Path.addLine(to: CGPoint(x: startX - halfWidth, y: triangleStartY))
        case .right:
            rectangle670Path.move(to: CGPoint(x: rect.width, y: startY))
            rectangle670Path.addLine(to: CGPoint(x: rect.width - triangleHeight, y: startY - halfWidth))
            rectangle670Path.addLine(to: CGPoint(x: rect.width - triangleHeight, y: startY + halfWidth))
            
        case .left:
            rectangle670Path.move(to: CGPoint(x: 0, y: startY))
            rectangle670Path.addLine(to: CGPoint(x: triangleHeight, y: startY - halfWidth))
            rectangle670Path.addLine(to: CGPoint(x: triangleHeight, y: startY + halfWidth))
        }
        
      
        rectangle670Path.miterLimit = 4;
        rectangle670Path.usesEvenOddFillRule = true;
        
        fillColor.setFill()
        rectangle670Path.fill()
        
        let roundedRect: CGRect
        switch arrowDirection {
        case .up:
            roundedRect = CGRect(x: 0, y: triangleHeight, width: rect.width, height: rect.height - triangleHeight)
        case .down:
            roundedRect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height - triangleHeight)
        case .right:
            roundedRect = CGRect(x: 0, y: 0, width: rect.width - triangleHeight, height: rect.height)
        case .left:
            roundedRect = CGRect(x: triangleHeight, y: 0, width: rect.width - triangleHeight, height: rect.height)
        }
        
        //// Rectangle-669 Drawing
        let rectangle669Path = UIBezierPath(roundedRect: roundedRect, cornerRadius: PopoverConfiguration.shared.cornerRadius)
        fillColor.setFill()
        rectangle669Path.fill()
        context?.endTransparencyLayer()
        context?.restoreGState()
    }

}







