//
//  ViewController.swift
//  Demo
//
//  Created by archerzz on 2017/5/6.
//
//

import UIKit
import PopoverKit

class ViewController: UIViewController {
    
    @IBAction func didClickAddItem(_ sender: UIBarButtonItem) {
        let vc = PopoverTableViewController(items: [.sortByDate, .sortByDirectory], selectedItemIndex: 0)
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = pop.transitioningDelegate
        vc.pop.popoverPresentationController?.barButtonItem = sender
        vc.pop.popoverPresentationController?.arrowPointY = self.navigationController?.navigationBar.frame.maxY
        vc.delegate = self
        PopoverConfiguration.shared.animation = .alpha
        PopoverConfiguration.shared.showDimmingView = false
        PopoverConfiguration.shared.backgroundColor = UIColor.lightGray
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func didClickUpButton(_ sender: UIButton) {
        PopoverConfiguration.shared.restoreDefalut()
        let vc = PopoverTableViewController(items: [.refresh, .adjustFontSize(.large)])
        vc.pop.isNeedPopover = true
        vc.pop.popoverPresentationController?.sourceView = sender
        vc.pop.popoverPresentationController?.sourceRect = sender.bounds
        vc.pop.popoverPresentationController?.arrowDirection = .up
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func didClickDownButton(_ sender: UIButton) {
        let vc = PopoverTableViewController(items: [.edit, .delete])
        vc.pop.isNeedPopover = true
        vc.pop.popoverPresentationController?.sourceView = sender
        vc.pop.popoverPresentationController?.sourceRect = sender.bounds
        vc.pop.popoverPresentationController?.arrowDirection = .down
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func didClickLeftButton(_ sender: UIButton) {
        let vc = PopoverTableViewController(items: [.openInSafari, .refresh, .share, .adjustFontSize(.large)])
        vc.pop.isNeedPopover = true
        vc.pop.popoverPresentationController?.sourceView = sender
        vc.pop.popoverPresentationController?.sourceRect = sender.bounds
        vc.pop.popoverPresentationController?.arrowDirection = .left
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func didClickRightButton(_ sender: UIButton) {
        let vc = PopoverTableViewController(items: [.openInSafari, .refresh, .share, .adjustFontSize(.large)])
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
    
    func didClick(item: PopoverTableViewController.Item, in vc: PopoverTableViewController) {
        dismiss(animated: true, completion: nil)
        print("archerzz: ", #function, #line, type(of: self))
    }
    
    func didClick(ajustFontType: PopoverTableViewController.AdjustFontType, in vc: PopoverTableViewController) {
        dismiss(animated: true, completion: nil)
        print("archerzz: ", #function, #line, type(of: self))
    }
    
}

