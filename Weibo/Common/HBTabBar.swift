//
//  HBTabBar.swift
//  sinaWeibo
//
//  Created by Beans on 16/6/24.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

class HBTabBar: UITabBar {

    // MARK: - 添加子控件
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(composeBtn)
    }

    // [系统提示] 加载storyboard时调用. 崩溃提示
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 布局
    override func layoutSubviews() {
        super.layoutSubviews()

        var index: Int  // 索引, 用于记录子控件x
        let itemW = bounds.width / 5
        let itemH = bounds.height

        composeBtn.frame = CGRectMake(2 * itemW, 0, itemW, itemH)
    }

    // MARK: - 懒加载控件
    private lazy var composeBtn: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        btn.addTarget(self, action: "composeBtnClick:", forControlEvents: .TouchUpInside)
        return btn
    }()

    // 私有方法, 运行过程中其它类找不到. 用'@objc关键字'
    @objc private func composeBtnClick(btn: UIButton) {
        printLog("composeBtnClick")
    }
}
