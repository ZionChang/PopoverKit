//
//  PopoverModel.swift
//  PopoverKit
//
//  Created by zz on 2017/5/31.
//
//

import Foundation
import UIKit

/// PopoverCellResuable
public protocol PopoverCellResuable: class {
    
    /// default is String(describing: self)
    static var reuseIdentifier: String { get }
    /// default nil
    static var nib: UINib? { get }
    
}

extension PopoverCellResuable {
    
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    public static var nib: UINib? {
        return nil
    }
}

/// PopoverCellConfiguration
public protocol PopoverCellConfiguration {
    
    /// tintColor default is 0x222222
    var tintColor: UIColor { get }
    
    /// maxMidth of cell
    var width: CGFloat { get }
    
    /// To get type
    var resuable: PopoverCellResuable.Type { get }
    
    /// config cell
    func config(cell: UITableViewCell)
    
}

extension PopoverCellConfiguration {
    
    public var tintColor: UIColor {
        return UIColor(red: 34 / 255.0, green: 34 / 255.0, blue: 34 / 255.0, alpha: 1)
    }
    
}


/// PureTitleModel
public struct PureTitleModel {
    
    public let title: String
    
    public init(title: String) {
        self.title = title
    }

}

// MARK: - PopoverCellConfiguration
extension PureTitleModel: PopoverCellConfiguration {
    
    public var width: CGFloat {
        guard let cell = PopoverPureTitleCell.nib?.instantiate(withOwner: nil, options: nil).first as? PopoverPureTitleCell else { return 0 }
        config(cell: cell)
        let width = cell.systemLayoutSizeFitting(UILayoutFittingCompressedSize).width
        return width
    }
    
    public var resuable: PopoverCellResuable.Type {
        return PopoverPureTitleCell.self
    }
    
    public func config(cell: UITableViewCell) {
        guard let cell  = cell as? PopoverPureTitleCell else {
            return
        }
        cell.titleLabel.textColor = tintColor
        cell.titleLabel.text = title
    }

}


/// NormalModel
public struct NormalModel {
    
    public let iconName: String
    public let description: String
    
    public init(iconName: String, description: String) {
        self.iconName = iconName
        self.description = description
    }
    
}


// MARK: - PopoverCellConfiguration
extension NormalModel: PopoverCellConfiguration {
    
    public var width: CGFloat {
        guard let cell = PopoverNormalCell.nib?.instantiate(withOwner: nil, options: nil).first as? PopoverNormalCell else { return 0 }
        config(cell: cell)
        let width = cell.systemLayoutSizeFitting(UILayoutFittingCompressedSize).width
        return width
    }

    public var resuable: PopoverCellResuable.Type {
        return PopoverNormalCell.self
    }
    
    public func config(cell: UITableViewCell)  {
        guard let cell  = cell as? PopoverNormalCell else {
            return
        }
        cell.descriptionLabel.textColor = tintColor
        cell.descriptionLabel.text = description
        cell.iconImageView.image = UIImage(named: iconName)
    }
}

