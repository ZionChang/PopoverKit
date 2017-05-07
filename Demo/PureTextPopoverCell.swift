//
//  PureTextPopoverCell.swift
//  MyCourse
//
//  Created by archerzz on 2017/5/5.
//  Copyright © 2017年 archerzz. All rights reserved.
//

import UIKit

/// NormalPopoverCell
final class PureTextPopoverCell: UITableViewCell, SelectedBackgroundBottomLinePresenter {
    
    let titleLabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

// MARK: - Setup
private extension PureTextPopoverCell {
    
    func setupUI() {
        backgroundColor = UIColor.clear
        contentView.addSubview(titleLabel)
        setupTitleLable()
        setupLineView()
        setupLineViewInSelectedBackgroundView()
    }
    
    func setupTitleLable() {
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.booklnBlackD
        titleLabel.textAlignment = .center
        titleLabel.highlightedTextColor = UIColor.booklnBlueA
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupLineView() {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.booklnBlackJ
        contentView.addSubview(lineView)
        
        lineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalTo(86)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
        }
    }
 
    
}

// MARK: - Reusable
extension PureTextPopoverCell: Reusable {}
