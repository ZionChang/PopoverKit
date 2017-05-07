//
//  CellBackgroundBottomLinePresenter.swift
//  Bookln
//
//  Created by archerzz on 16/7/12.
//  Copyright © 2016年 Hangzhou Yunti Technology Co. Ltd. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

/**
 @author archerzz, 2017-05-05
 
 给cell高亮的时候添加下划线
 
 @since 2.7.3
 */
protocol SelectedBackgroundBottomLinePresenter {
    func setupLineViewInSelectedBackgroundView()
}

// MARK: - 默认实现
extension SelectedBackgroundBottomLinePresenter where Self: UITableViewCell {
    
    func setupLineViewInSelectedBackgroundView() {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        let lineView = UIView()
        view.addSubview(lineView)
        lineView.backgroundColor = UIColor.booklnBlackJ
        lineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview().offset(-0.5)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
        }
        selectedBackgroundView = view
    }
    
}
