//
//  PopoverTableViewController.swift
//  CCPopoverViewController
//
//  Created by archerzz on 2017/5/5.
//  Copyright © 2017年 archerzz. All rights reserved.
//

import UIKit


/// PopoverTableViewControllerDelegate
protocol PopoverTableViewControllerDelegate: class {
    
    func didClick(item: PopoverTableViewController.Item, in vc: PopoverTableViewController)
    
    func didClick(ajustFontType: PopoverTableViewController.AdjustFontType, in vc: PopoverTableViewController)
    
}

extension PopoverTableViewControllerDelegate {
    
    func didClick(item: PopoverTableViewController.Item, in vc: PopoverTableViewController) {}
    
    func didClick(ajustFontType: PopoverTableViewController.AdjustFontType, in vc: PopoverTableViewController) {}
    
}

/// MaxWidth
fileprivate protocol MaxWidth {
    func maxWidth() -> CGFloat
}

/// 笔记弹框
final class PopoverTableViewController: UITableViewController {
    
    enum Item {
        case sortByDate
        case sortByPage
        case sortByDirectory
        case edit
        case delete
        case openInSafari
        case refresh
        case share
        case adjustFontSize(AdjustFontType)
        
        fileprivate func model() -> MaxWidth {
            switch self {
            case .sortByDate:
                return PureTitleModel(title: "按时间排序")
            case .sortByPage:
                return PureTitleModel(title: "按页码排序")
            case .sortByDirectory:
                return PureTitleModel(title: "按目录排序")
            case .edit:
                return NormalModel(iconName: "ic_note_edit", description: "编辑")
            case .delete:
                return NormalModel(iconName: "ic_note_delete", description: "删除")
            case .openInSafari:
                return NormalModel(iconName: "ic_browser", description: "浏览器打开")
            case .refresh:
                return NormalModel(iconName: "ic_refresh_1", description: "刷新")
            case .share:
                return NormalModel(iconName: "ic_share_1", description: "分享")
            case .adjustFontSize(let type):
                return AdjustFontModel(type: type)
            }

        }
        
    }
    
    enum AdjustFontType {
        case medium
        case large
        case extraLarge
    }
    
    fileprivate struct PureTitleModel: MaxWidth {
        
        let title: String
        
        func maxWidth() -> CGFloat {
            let cell = PureTextPopoverCell()
            cell.titleLabel.text = title
            let width = cell.systemLayoutSizeFitting(UILayoutFittingCompressedSize).width
            return width
        }
        
    }
    
    fileprivate struct NormalModel: MaxWidth {
        
        let iconName: String
        let description: String
        
        func maxWidth() -> CGFloat {
            let cell = NormalPopoverCell()
            cell.descriptionLabel.text = description
            cell.iconImageView.image = UIImage(named: iconName)
            let width = cell.systemLayoutSizeFitting(UILayoutFittingCompressedSize).width
            return width
        }
    }
    
    
    
    fileprivate struct AdjustFontModel: MaxWidth {
        
        let type: AdjustFontType
        
        func maxWidth() -> CGFloat {
            let cell = AjustFontPopoverCell()
            let width = cell.systemLayoutSizeFitting(UILayoutFittingCompressedSize).width
            return width
        }
        
    }
    
    fileprivate let items: [Item]
    fileprivate let rowHeight: CGFloat = 40
    fileprivate let selectedItemIndex: Int?
    
    init(items: [Item], selectedItemIndex: Int? = nil) {
        self.items = items
        self.selectedItemIndex = selectedItemIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: PopoverTableViewControllerDelegate?
    
    deinit {
        print("archerzz: ", #function, #line, type(of: self))
    }
    
    override var preferredContentSize: CGSize {
        get {
            let height: CGFloat = CGFloat(items.count) * rowHeight - 1
            let width = items.map { $0.model().maxWidth() }.max() ?? 0
            
            return CGSize(width: width, height: height)
        }
        set {
            super.preferredContentSize = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear
        tableView.register(PureTextPopoverCell.self)
        tableView.register(NormalPopoverCell.self)
        tableView.register(AjustFontPopoverCell.self)
        tableView.rowHeight = rowHeight
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.item]
        switch item {
        case .sortByDate, .sortByPage, .sortByDirectory:
            let cell = tableView.dequeueReusableCell(for: indexPath) as PureTextPopoverCell
            if let model = item.model() as? PureTitleModel {
                cell.titleLabel.text = model.title
            }
            return cell
        
        case .edit, .delete, .openInSafari, .refresh, .share:
            let cell = tableView.dequeueReusableCell(for: indexPath) as NormalPopoverCell
            if let model = item.model() as? NormalModel {
                cell.descriptionLabel.text = model.description
                cell.iconImageView.image = UIImage(named: model.iconName)
            }
            return cell
       
        case .adjustFontSize(let selectedSize):
            let cell = tableView.dequeueReusableCell(for: indexPath) as AjustFontPopoverCell
            cell.updateState(with: selectedSize)
            cell.delegate = self
            return cell
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isSeleted = (self.selectedItemIndex ?? -1) == indexPath.item
        cell.isSelected = isSeleted
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didClick(item: items[indexPath.item], in: self)
    }


}

// MARK: - AjustFontPopoverCellDelegate
extension PopoverTableViewController: AjustFontPopoverCellDelegate {
    
    func didClickMediumButton(in cell: AjustFontPopoverCell) {
        delegate?.didClick(ajustFontType: .medium, in: self)
    }
    
    func didClickLargeButton(in cell: AjustFontPopoverCell) {
        delegate?.didClick(ajustFontType: .large, in: self)
    }
    
    func didClickExtraLargeButton(in cell: AjustFontPopoverCell) {
        delegate?.didClick(ajustFontType: .extraLarge, in: self)
    }
    
}













