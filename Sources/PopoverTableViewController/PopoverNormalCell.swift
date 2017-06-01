//
//  PopoverNormalCell.swift
//  PopoverKit
//
//  Created by zz on 2017/5/31.
//
//

import UIKit

/// 还有icon的cell
open class PopoverNormalCell: UITableViewCell {
    
    /// icon
    @IBOutlet public weak var iconImageView: UIImageView!
    /// description
    @IBOutlet public weak var descriptionLabel: UILabel!
    
    @IBOutlet public weak var lineView: UIView!
}

// MARK: - PopoverCellResuable
extension PopoverNormalCell: PopoverCellResuable {
    
    public static var nib: UINib? {
        return UINib(nibName: reuseIdentifier, bundle: Bundle(for: self))
    }
    
}
