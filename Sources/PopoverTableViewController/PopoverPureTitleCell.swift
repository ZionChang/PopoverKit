//
//  PopoverPureTitleCell.swift
//  PopoverKit
//
//  Created by zz on 2017/5/31.
//
//

import UIKit

/// 纯文本cell
open class PopoverPureTitleCell: UITableViewCell {

    /// title
    @IBOutlet public weak var titleLabel: UILabel!
    
    @IBOutlet public weak var lineView: UIView!
    
}


// MARK: - PopoverCellResuable
extension PopoverPureTitleCell: PopoverCellResuable {
    
    public static var nib: UINib? {
        return UINib(nibName: reuseIdentifier, bundle: Bundle(for: self))
    }
    
}
