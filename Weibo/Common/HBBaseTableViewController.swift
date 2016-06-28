//
//  HBBaseTableViewController.swift
//  Weibo
//
//  Created by Beans on 16/6/25.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

class HBBaseTableViewController: UITableViewController {

    var isLogin: Bool = false

    // 控制器的生命周期 loadView 方法 (创建一个视图)
    // 1. 若不调用super.loadView(), 视图是黑的, 且是一个死循环
    // 2. 不调用super, 但当一个视图填充整个控制器, 可指定一个view
    override func loadView() {
        if isLogin {
            super.loadView()
        } else {
            // 显示访客视图
            view = UIView(frame: UIScreen.mainScreen().bounds)
            view.backgroundColor = UIColor.lightGrayColor()

            setupNav()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // 导航栏
    private func setupNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: "registerBtnClick")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .Plain, target: self, action: "loginBtnClick")
    }
}

// 隔离代码用
extension HBBaseTableViewController {

    func registerBtnClick() {
        printLog("register item/btn click")
    }

    func loginBtnClick() {
        printLog("login item/btn click")
    }
}

