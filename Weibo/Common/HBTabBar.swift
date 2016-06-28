//
//  HBTabBar.swift
//  sinaWeibo
//
//  Created by Beans on 16/6/24.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

class HBTabBar: UITabBar {

    // ①.定义闭包
    var composeBtnClosure: (()->())?

    // MARK: - 添加子控件
    // init(frame:) -- 是 UIView的指定构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(composeBtn)
    }

    // [系统提示] 加载storyboard时调用. 崩溃提示
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()

        var index: Int = 0  // 索引, 用于记录子控件x
        let btnW = bounds.width / 5
        let btnH = bounds.height
        // 遍历, 改变btn位置
        for subview in subviews {

            /* UITabBarButton 是系统的私有类, 不对外公开; isKindOfClass 用于判断是不是这个类 */
            if subview.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                subview.frame = CGRectMake(CGFloat(index) * btnW, 0, btnW, btnH)
                index++

                if index == 2 { index++ }   // 第三个位置空出来, 放"+"按钮
            }
        }

        composeBtn.frame = CGRectMake(2 * btnW, 0, btnW, btnH)
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

    // 私有方法, 运行过程中其它类找不到. 用'@objc'关键字
    @objc private func composeBtnClick(btn: UIButton) {
        printLog("composeBtnClick")
        // ②.调用闭包
        composeBtnClosure?()
    }
}
