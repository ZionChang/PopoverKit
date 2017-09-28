//
//  ViewController.swift
//  Demo
//
//  Created by archerzz on 2017/5/6.
//
//

import UIKit
import PopoverKit


/// Custom
struct CustomModel: PopoverCellConfiguration {
    
    public var width: CGFloat {
        let cell = AjustFontPopoverCell()
        config(cell: cell)
        let width = cell.systemLayoutSizeFitting(UILayoutFittingCompressedSize).width
        return width
    }
    
    public var resuable: PopoverCellResuable.Type {
        return AjustFontPopoverCell.self
    }
    
    public func config(cell: UITableViewCell) {
        guard cell is AjustFontPopoverCell else {
            return
        }
        // config delegate...
    }
    
    
}

class ViewController: UIViewController {
    
    let sortByDate = PureTitleModel(title: "按时间排序")
    let sortBySize = PureTitleModel(title: "按大小排序")
    let edit = NormalModel(iconName: "ic_note_edit", description: "编辑")
    let delete = NormalModel(iconName: "ic_note_delete", description: "删除")
    let customModel = CustomModel()
    
    @IBAction func didClickAddItem(_ sender: UIBarButtonItem) {
        
        let vc = PopoverTableViewController(items: [sortByDate, sortBySize])
        vc.pop.isNeedPopover = true
        vc.pop.popoverPresentationController?.barButtonItem = sender
        vc.pop.popoverPresentationController?.arrowPointY = self.navigationController?.navigationBar.frame.maxY
        vc.delegate = self
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func didClickUpButton(_ sender: UIButton) {
        let vc = PopoverTableViewController(items: [sortByDate, sortBySize])
        vc.pop.isNeedPopover = true
        vc.pop.popoverPresentationController?.sourceView = sender
        vc.pop.popoverPresentationController?.sourceRect = sender.bounds
        vc.pop.popoverPresentationController?.arrowDirection = .up
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func didClickDownButton(_ sender: UIButton) {
        let vc = PopoverTableViewController(items: [edit, delete, sortByDate])
        vc.pop.isNeedPopover = true
        vc.pop.popoverPresentationController?.sourceView = sender
        vc.pop.popoverPresentationController?.sourceRect = sender.bounds
        vc.pop.popoverPresentationController?.arrowDirection = .down
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func didClickLeftButton(_ sender: UIButton) {
        let vc = PopoverTableViewController(items: [edit, delete])
        vc.pop.isNeedPopover = true
        vc.pop.popoverPresentationController?.sourceView = sender
        vc.pop.popoverPresentationController?.sourceRect = sender.bounds
        vc.pop.popoverPresentationController?.arrowDirection = .left
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func didClickRightButton(_ sender: UIButton) {
        let vc = PopoverTableViewController(items: [edit, delete])
        vc.pop.isNeedPopover = true
        vc.pop.popoverPresentationController?.sourceView = sender
        vc.pop.popoverPresentationController?.sourceRect = sender.bounds
        vc.pop.popoverPresentationController?.arrowDirection = .right
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func didClickCustomButton(_ sender: UIButton) {
        let vc = PopoverTableViewController(items: [customModel])
        vc.pop.isNeedPopover = true
        vc.pop.popoverPresentationController?.sourceView = sender
        vc.pop.popoverPresentationController?.sourceRect = sender.bounds
        vc.pop.popoverPresentationController?.arrowDirection = .right
        vc.delegate = self
        present(vc, animated: true, completion: nil)
        
        
    }
    
}

// MARK: - PopoverTableViewControllerDelegate
extension ViewController: PopoverTableViewControllerDelegate {
    
    func didSelectRow(at indexPath: IndexPath, in vc: PopoverTableViewController) {
        print("indexPath: ", indexPath, #function, #line, type(of: self))
    }
    
}














