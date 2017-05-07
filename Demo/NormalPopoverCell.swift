//
//  NormalPopoverCell.swift
//  MyCourse
//
//  Created by archerzz on 2017/5/5.
//  Copyright © 2017年 archerzz. All rights reserved.
//

import UIKit
import Then

/// NormalPopoverCell
final class NormalPopoverCell: UITableViewCell, SelectedBackgroundBottomLinePresenter {

    let iconImageView = UIImageView()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


// MARK: - Setup
private extension NormalPopoverCell {
    
    func setupUI() {
        backgroundColor = UIColor.clear
        let containerView = UIView()
        containerView.addSubview(iconImageView)
        containerView.addSubview(descriptionLabel)
        
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.top.bottom.equalToSuperview()
        }
        
        descriptionLabel.do {
            $0.font = UIFont.systemFont(ofSize: 16)
            $0.textColor = UIColor.booklnBlackD
            $0.highlightedTextColor = UIColor.booklnBlueA
        }
        
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        iconImageView.setContentHuggingPriority(260, for: .horizontal)
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        
        setupLineView()
        setupLineViewInSelectedBackgroundView()
        
    }
    
    func setupLineView() {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.booklnBlackJ
        contentView.addSubview(lineView)
        
        lineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
        }
    }
    
    
    
}

// MARK: - Reusable
extension NormalPopoverCell: Reusable {}
