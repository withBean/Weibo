//
//  HBHomeTableViewCell.swift
//  Weibo
//
//  Created by Beans on 16/7/13.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

/**
 原创微博, 转发微博, 转发/评论/点赞栏; 图片视图在原创微博和转发微博内部判断处理
 */

import UIKit

class HBHomeTableViewCell: UITableViewCell {

    var viewModel: HBStatusCellViewModel? {
        didSet {
            originalView.viewModel = viewModel
            footerView.viewModel = viewModel
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(originalView)
        contentView.addSubview(repostView)
        contentView.addSubview(footerView)

        originalView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(contentView)
            make.bottom.equalTo(repostView.snp_top)
        }
        repostView.snp_makeConstraints { (make) in
            make.left.right.equalTo(contentView)    // 最好将可变约束(此处top/bottom)设置在永久视图上, 以便更新约束
            // temp
//            make.height.equalTo(100)
        }
        footerView.snp_makeConstraints { (make) in
            make.top.equalTo(repostView.snp_bottom)
            make.left.right.bottom.equalTo(contentView)
            // temp
//            make.height.equalTo(100)
        }

        // 自动计算行高 (contentView, 尤其注意底部)
        contentView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }

    // MARK: - lazy load
    private lazy var originalView: HBOriginalView = HBOriginalView()
    private lazy var repostView: HBRepostView = HBRepostView()
    private lazy var footerView: HBFooterView = HBFooterView()
}
