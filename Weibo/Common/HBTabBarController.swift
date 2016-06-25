//
//  HBTabBarController.swift
//  sinaWeibo
//
//  Created by Beans on 16/6/24.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

class HBTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let homeVc: HBHomeViewController = HBHomeViewController()
//        homeVc.title = ""
//        homeVc.tabBarItem.image = UIImage(named: "")
//        homeVc.tabBarItem.selectedImage = UIImage(named: "")
//        addChildViewController(UINavigationController(rootViewController: homeVc))

        // 添加子控制器
        addChildViewController()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /// 重载 -- 添加childVc
    func addChildViewController(childController: UIViewController, title: String, image: String) {
        childController.title = title
        childController.tabBarItem.image = UIImage(named: image)
        childController.tabBarItem.selectedImage = UIImage(named: "\(image)_highlighted")

        addChildViewController(UINavigationController(rootViewController: childController))
    }

    /// 重载 -- 抽取无参函数
    func addChildViewController() {
        addChildViewController(HBHomeViewController(), title: "首页", image: "tabbar_home")
        addChildViewController(HBMessageViewController(), title: "消息", image: "tabbar_message_center")
        addChildViewController(HBFindViewController(), title: "发现", image: "tabbar_discover")
        addChildViewController(HBSettingViewController(), title: "设置", image: "tabbar_profile")
    }
}
