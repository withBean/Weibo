//
//  HBHomeViewController.swift
//  sinaWeibo
//
//  Created by Beans on 16/6/24.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

let HBHomeViewControllerCellReuseIdentifier = "HBHomeViewControllerCellReuseIdentifier"

class HBHomeViewController: HBBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 判断是否登录(基类). 登录以后才加载数据以及展示首页微博, 否则显示首页访客视图
        if isLogin {

            // 1.加载数据
            loadHomeData()
            // 2.展示tableView界面
            // 注册cell (类型.self -> 指定类)
            tableView.registerClass(HBHomeTableViewCell.self, forCellReuseIdentifier: HBHomeViewControllerCellReuseIdentifier)
            tableView.estimatedRowHeight = 200

        } else {
            visitorView.setupVisitorViewInfo("visitordiscover_feed_image_house", message: "关注一些人, 回这里看看有什么惊喜", isRolling: true)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - 加载首页数据
    private func loadHomeData() {
        let since_id: Int = 0
        let max_id: Int = 0
        HBStatusListViewModel.sharedInstance.loadData(since_id, max_id: max_id, success: { 
            // 更新数据
            self.tableView.reloadData()

            }) { 
                // 失败
        }
    }
}

// 隔离代码用 tableView的数据源及代理方法
extension HBHomeViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HBStatusListViewModel.sharedInstance.statusList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(HBHomeViewControllerCellReuseIdentifier, forIndexPath: indexPath) as! HBHomeTableViewCell
        // 取消选中状态
        cell.selectionStyle = UITableViewCellSelectionStyle.None

        let model = HBStatusListViewModel.sharedInstance.statusList[indexPath.row]
        cell.viewModel = model

        return cell
    }
}
