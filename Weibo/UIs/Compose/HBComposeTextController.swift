//
//  HBComposeTextController.swift
//  Weibo
//
//  Created by Beans on 16/7/4.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

class HBComposeTextController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyanColor()
        setupNav()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func setupNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: .Plain, target: self, action: "dismissItemClick")
    }

    @objc private func dismissItemClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
