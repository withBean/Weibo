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
    let visitorView = HBVisitorView()   // 定义为成员变量, 便于childVc调用并更改设置

    // 控制器的生命周期 loadView 方法 (创建一个视图)
    // 1. 若不调用super.loadView(), 视图是黑的, 且是一个死循环
    // 2. 不调用super, 但当一个视图填充整个控制器, 可指定一个view
    override func loadView() {
        if isLogin {
            super.loadView()
        } else {
            // 显示访客视图
            view = visitorView
            visitorView.startAnimation()
            
            // <5> 设置代理
            visitorView.delegate = self

            setupNav()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // 导航栏
    private func setupNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: "didRegister")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .Plain, target: self, action: "didLogin")
    }
}

// extension此处隔离代码用
// <4> 遵守协议
extension HBBaseTableViewController: HBVisitorViewDelegate {

    // <6> 实现代理方法
    func didRegister() {
        printLog("register item/btn click")
    }

    func didLogin() {
        printLog("login item/btn click")
    }
}

