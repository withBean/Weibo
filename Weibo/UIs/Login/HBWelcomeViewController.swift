//
//  HBWelcomeViewController.swift
//  Weibo
//
//  Created by Beans on 16/7/4.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

// 两个问题:
// 1> 视图控制器的生命周期 --> willDidAppear
// 2> 约束动画的调用 --> layoutIfNeeded

class HBWelcomeViewController: UIViewController {

    override func loadView() {
        // 背景添加满视图, 可以借助于loadView (不用super, 直接赋值即可)
        view = bgImageView
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        iconViewAnimation()
    }

    // 视图出现之后, 再开启动画
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        iconViewAnimation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        iconViewAnimation()
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func setupUI() {
        view.addSubview(iconView)
        view.addSubview(msgLbl)

        iconView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(120)
        }
        msgLbl.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView)
            make.top.equalTo(iconView.snp_bottom).offset(10)
        }
    }

    // MARK: - 头像的动画
    // 1> 视图控制器的生命周期 --> willDidAppear
    // 2> 约束动画的调用 --> layoutIfNeeded
    private func iconViewAnimation() {

        UIView.animateWithDuration(2.0, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: [], animations: { () -> Void in
            // 更新约束 (注意约束一致且唯一)
            self.iconView.snp_updateConstraints(closure: { (make) -> Void in
                make.centerY.equalTo(self.view).offset(-150)
            })
            // 约束动画的调用 (修改frame一瞬间, 需单独调用)
            self.view.layoutIfNeeded()

            }) { (_) -> Void in
                // 跳转控制器
        }
    }

    // MARK: - lazy load
    private lazy var bgImageView: UIImageView = UIImageView(image: UIImage(named: "ad_background"))

    private lazy var iconView: UIImageView = {
        let imgV = UIImageView(image: UIImage(named: "avatar_default_big"))
        imgV.layer.cornerRadius = 170 / 4.0
        imgV.layer.masksToBounds = true
        imgV.layer.borderWidth = 1.0
        imgV.layer.borderColor = UIColor.magentaColor().CGColor
        imgV.sizeToFit()
        return imgV
    }()

    private lazy var msgLbl: UILabel = UILabel(text: "欢迎回来", fontSize: 16.0, textColor: UIColor.darkGrayColor(), textAlignment: .Center, numberOfLines: 1)
}
