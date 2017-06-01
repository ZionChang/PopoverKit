//
//  PopoverTableViewController.swift
//  CCPopoverViewController
//
//  Created by archerzz on 2017/5/5.
//  Copyright © 2017年 archerzz. All rights reserved.
//

import UIKit


/// PopoverTableViewControllerDelegate
public protocol PopoverTableViewControllerDelegate: class {
    
    func didSelectRow(at indexPath: IndexPath, in vc: PopoverTableViewController)
    
}

extension PopoverTableViewControllerDelegate {
    
    func didSelectRow(at indexPath: IndexPath, in vc: PopoverTableViewController) {}
    
}

fileprivate struct Identifier: RawRepresentable {
    let rawValue: String
    static let pure = Identifier(rawValue: String(describing: PopoverPureTitleCell.self))
    static let normal = Identifier(rawValue: String(describing: PopoverNormalCell.self))
}

/// PopoverTableViewController
public class PopoverTableViewController: UITableViewController {
    
    fileprivate let items: [PopoverCellConfiguration]
    fileprivate let rowHeight: CGFloat = 40
    fileprivate let selectedItemIndex: Int?
    
    deinit {
        print("archerzz: ", #function, #line, type(of: self))
    }
    
    public init(items: [PopoverCellConfiguration], selectedItemIndex: Int? = nil) {
        self.items = items
        self.selectedItemIndex = selectedItemIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// PopoverTableViewControllerDelegate
    public weak var delegate: PopoverTableViewControllerDelegate?
    
    /// Default is UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    public var contentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    
    override public var preferredContentSize: CGSize {
        get {
            let height: CGFloat = (CGFloat(items.count) * rowHeight - 1) + contentInset.top + contentInset.bottom
            let width = (items.map { $0.width }.max() ?? 0) + contentInset.left + contentInset.right
            return CGSize(width: width, height: height)
        }
        set {
            super.preferredContentSize = newValue
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        items.forEach {
            if let nib = $0.resuable.nib {
                tableView.register(nib, forCellReuseIdentifier: $0.resuable.reuseIdentifier)
            } else {
                tableView.register($0.resuable, forCellReuseIdentifier: $0.resuable.reuseIdentifier)
            }
        }
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = rowHeight
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }

    // MARK: - Table view data source
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.resuable.reuseIdentifier)!
        item.config(cell: cell)
        return cell

    }
    
    override public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isSeleted = (self.selectedItemIndex ?? -1) == indexPath.item
        cell.isSelected = isSeleted
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRow(at: indexPath, in: self)
    }


}













