//
//  Reusable.swift
//  RedPoint
//
//  Created by archerzz on 16/10/11.
//  Copyright © 2016年 archerzz. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 自定义泛型
protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

// MARK: - Reusable默认实现
extension Reusable {
    // 默认使用当前类名
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

/// Nib
protocol NibReusable: Reusable, NibLoadable {}
protocol NibLoadable: class {
    static var nib: UINib { get }
}
// MARK: - NibReusable默认实现
extension NibLoadable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

extension NibLoadable where Self: UIView {
    
    static func loadFromNib() -> Self? {
        
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
           return nil
        }
        return view
    }
}


// MARK: - 拓展tableView 前提cell遵守Reusable
extension UITableView {
    
    func register<T: UITableViewCell>(_ type : T.Type) where T: Reusable {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UITableViewCell>(_ type : T.Type) where T: NibReusable {
        self.register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T? where T: Reusable {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T?
    }
}

// MARK: - 拓展collectionView 前提cell遵守Reusable
extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ type : T.Type) where T: Reusable {
        self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UICollectionViewCell>(_ type : T.Type) where T: NibReusable {
        self.register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func register<T: Reusable>(_ type: T.Type, forSupplementaryViewOfKind elementKind: String) {
        self.register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: NibReusable>(_ type: T.Type, forSupplementaryViewOfKind elementKind: String) {
        self.register(T.nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionViewCell>(ofKind elementKind: String, for indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as! T
    }
}
