//
//  HBRepostView.swift
//  Weibo
//
//  Created by Beans on 16/7/13.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

class HBRepostView: UIView {

    var viewModel: HBStatusCellViewModel? {
        didSet {
            repostContent.text = viewModel?.repostContent
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = colorWithHexString("FFFFCC")

        addSubview(repostContent)

        repostContent.snp_makeConstraints { (make) in
            make.top.left.equalTo(self).offset(cellMargin)
            make.right.equalTo(self).offset(-cellMargin)
        }

        self.snp_makeConstraints { (make) in
            make.bottom.equalTo(repostContent)
        }
    }

    // MARK: - lazy load
    private lazy var repostContent: UILabel = UILabel(text: "这里是转发的微博", fontSize: 15.0, textColor: .darkGrayColor(), textAlignment: .Left, numberOfLines: 0)

}
