//
//  AjustFontPopoverCell.swift
//  MyCourse
//
//  Created by archerzz on 2017/5/6.
//  Copyright © 2017年 archerzz. All rights reserved.
//

import UIKit

protocol AjustFontPopoverCellDelegate: class {
    func didClickMediumButton(in cell: AjustFontPopoverCell)
    func didClickLargeButton(in cell: AjustFontPopoverCell)
    func didClickExtraLargeButton(in cell: AjustFontPopoverCell)
}

/// 字体调整cell
final class AjustFontPopoverCell: UITableViewCell {
    
    fileprivate let mediumButton = UIButton()
    fileprivate let largeButton = UIButton()
    fileprivate let extraLargeButton = UIButton()
    
    weak var delegate: AjustFontPopoverCellDelegate?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - Logic
extension AjustFontPopoverCell {
    
    func updateState(with seletedSize: PopoverTableViewController.AdjustFontType) {
        switch seletedSize {
        case .medium:
            updateFontButtonStatus(with: mediumButton)
        case .large:
            updateFontButtonStatus(with: largeButton)
        case .extraLarge:
            updateFontButtonStatus(with: extraLargeButton)
        }
    }
    
}

// MARK: - Setup
private extension AjustFontPopoverCell {
    
    func setupUI() {
        
        selectionStyle = .none
        backgroundColor = UIColor.clear
        
        let containerView = UIView()
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
            $0.center.equalToSuperview()
        }
            
        containerView.do {
            $0.addSubview(mediumButton)
            $0.addSubview(largeButton)
            $0.addSubview(extraLargeButton)
        }
        
        
        mediumButton.do {
            $0.setTitle("Aa", for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            $0.setTitleColor(UIColor.booklnBlackD, for: .normal)
            $0.setTitleColor(UIColor.booklnBlueA, for: .selected)
            $0.addTarget(self, action: #selector(didClickMediaButton(_:)), for: .touchUpInside)
        }
        
        largeButton.do {
            $0.setTitle("Aa", for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            $0.setTitleColor(UIColor.booklnBlackD, for: .normal)
            $0.setTitleColor(UIColor.booklnBlueA, for: .selected)
            $0.addTarget(self, action: #selector(didClickLargeButton(_:)), for: .touchUpInside)
        }
        
        extraLargeButton.do {
            $0.setTitle("Aa", for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 21)
            $0.setTitleColor(UIColor.booklnBlackD, for: .normal)
            $0.setTitleColor(UIColor.booklnBlueA, for: .selected)
            $0.addTarget(self, action: #selector(didClickExtraLargeButton(_:)), for: .touchUpInside)
        }
        
        mediumButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(12).priority(900)
        }
        
        largeButton.snp.makeConstraints {
            $0.leading.equalTo(mediumButton.snp.trailing).offset(20).priority(900)
            $0.top.bottom.width.equalTo(mediumButton)
        }
        
        extraLargeButton.snp.makeConstraints {
            $0.leading.equalTo(largeButton.snp.trailing).offset(20).priority(900)
            $0.top.bottom.width.equalTo(largeButton)
            $0.trailing.equalToSuperview().offset(-12).priority(900)
        }
        
        setupLineView()
    }
  
    
    func setupLineView() {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.booklnBlackJ
        contentView.addSubview(lineView)
        
        lineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(mediumButton.snp.leading)
            $0.trailing.equalTo(extraLargeButton.snp.trailing)
        }
    }
    
    
}


// MARK: - Actions
private extension AjustFontPopoverCell {
    
    @objc func didClickMediaButton(_ sender: UIButton) {
        updateFontButtonStatus(with: sender)
        delegate?.didClickMediumButton(in: self)
    }
    @objc func didClickLargeButton(_ sender: UIButton) {
        updateFontButtonStatus(with: sender)
        delegate?.didClickLargeButton(in: self)
    }
    @objc func didClickExtraLargeButton(_ sender: UIButton) {
        updateFontButtonStatus(with: sender)
        delegate?.didClickExtraLargeButton(in: self)
    }
    
    func updateFontButtonStatus(with sender: UIButton) {
        mediumButton.isSelected = false
        largeButton.isSelected = false
        extraLargeButton.isSelected = false
        
        sender.isSelected = true
    }
    
    
}

// MARK: - Reusable
extension AjustFontPopoverCell: Reusable {}
