//
//  HBVisitorView.swift
//  Weibo
//
//  Created by Beans on 16/6/25.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

// <1> 声明协议
protocol HBVisitorViewDelegate: NSObjectProtocol {
    func didRegister()
    func didLogin()
}

class HBVisitorView: UIView {

    // <2> 设置代理属性
    var delegate: HBVisitorViewDelegate?

    // 自定义视图三部曲:
    // 1. 重写构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 237/255.0, alpha: 1.0)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 2. 定义方法, 添加和布局子控件
    private func setupUI() {
        addSubview(houseImgView)
        addSubview(rollingImgView)
        addSubview(maskImgView)
        addSubview(noticeLbl)
        addSubview(registerBtn)
        addSubview(loginBtn)

        houseImgView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self)
        }
        rollingImgView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self)
        }
        maskImgView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self)
        }
        noticeLbl.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(houseImgView.snp_bottom).offset(10)
            make.centerX.equalTo(self)
            make.width.equalTo(216)
        }
        registerBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(noticeLbl.snp_bottom).offset(10)
            make.left.equalTo(noticeLbl)
            make.width.equalTo(100)
        }
        loginBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(registerBtn)
            make.right.equalTo(noticeLbl)
            make.width.equalTo(100)
        }
    }

    @objc private func registerBtnClick(btn: UIButton) {
        // <三> 调用代理方法 (不需判断, 因为是optional)
        delegate?.didRegister()
    }

    @objc private func loginBtnClick(btn: UIButton) {
        delegate?.didLogin()
    }

    // 3. 懒加载子控件 (此处以首页为例, 可后期修改)
    // 小房子
    private lazy var houseImgView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))

    // 旋转图片
    private lazy var rollingImgView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))

    // 蒙层 (图片, 遮盖旋转下半部)
    private lazy var maskImgView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))

    private lazy var noticeLbl: UILabel = UILabel(text: "关注一些人, 回这里看看有什么惊喜", fontSize: 15.0, textColor: UIColor.darkGrayColor(), textAlignment: .Center, numberOfLines: 0)

//    private lazy var registerBtn: UIButton = UIButton(title: "注 册", titleColor: .orangeColor(), image: "", backgroundImage: "common_button_white_disable", backgroundColor: UIColor.clearColor(), target: "registerBtnClick:")    // 事件有问题

    private lazy var registerBtn: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.setBackgroundImage(UIImage.resizeImageWithImageName("common_button_white_disable"), forState: .Normal)
        btn.setTitle("注 册", forState: .Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        btn.addTarget(self, action: "registerBtnClick:", forControlEvents: .TouchUpInside)
        return btn
    }()

    private lazy var loginBtn: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.setBackgroundImage(UIImage.stretchImageWithImageName("common_button_white_disable"), forState: .Normal)
        btn.setTitle("登 录", forState: .Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        btn.addTarget(self, action: "loginBtnClick:", forControlEvents: .TouchUpInside)
        return btn
    }()

}
