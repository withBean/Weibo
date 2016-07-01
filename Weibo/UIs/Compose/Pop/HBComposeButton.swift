//
//  HBComposeButton.swift
//  Weibo
//
//  Created by Beans on 16/7/1.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

class HBComposeButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        imageView?.contentMode = .Center

        titleLabel?.textColor = UIColor.darkGrayColor()
        titleLabel?.textAlignment = .Center
        titleLabel?.font = UIFont.systemFontOfSize(16.0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let imgViewWH: CGFloat = self.bounds.width
        imageView?.frame = CGRectMake(0, 0, imgViewWH, imgViewWH)
        titleLabel?.frame = CGRectMake(0, imgViewWH, imgViewWH, self.bounds.height - imgViewWH)
    }

}
