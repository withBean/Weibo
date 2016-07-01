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
        addSubview(rollingImgView)
        addSubview(maskImgView)
        addSubview(houseImgView)    // 后添加house, 就不会被遮住了
        addSubview(messageLbl)
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
        messageLbl.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(maskImgView.snp_bottom).offset(10)     // 素材中, house太小, 故以其它的作参考
            make.centerX.equalTo(self)
            make.width.equalTo(216)
        }
        registerBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(messageLbl.snp_bottom).offset(10)
            make.left.equalTo(messageLbl)
            make.width.equalTo(100)
        }
        loginBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(registerBtn)
            make.right.equalTo(messageLbl)
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

    // MARK: - 动画 (CABasicAnimation)
    func startAnimation() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")  // 注意!
        anim.toValue = M_PI * 2
        anim.duration = 10.0
        anim.repeatCount = MAXFLOAT
        anim.removedOnCompletion = false    // 防止切换视图时动画停止
        rollingImgView.layer.addAnimation(anim, forKey: "HBVisitorViewRollingImgView")  // or nil
    }

    // MARK: - 供其它控制器修改本访客视图属性
    func setupVisitorViewInfo(image: String, message: String, isRolling: Bool) {
        houseImgView.image = UIImage(named: image)
        messageLbl.text = message

        if isRolling {
            rollingImgView.hidden = false
            maskImgView.hidden = false
            startAnimation()
        } else {
            rollingImgView.hidden = true
            maskImgView.hidden = true
        }
    }

    // 3. 懒加载子控件 (此处以首页为例, 可后期修改)
    // 小房子
    private lazy var houseImgView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))

    // 旋转图片
    private lazy var rollingImgView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))

    // 蒙层 (图片, 遮盖旋转下半部)
    private lazy var maskImgView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))

    private lazy var messageLbl: UILabel = UILabel(text: "关注一些人, 回这里看看有什么惊喜", fontSize: 15.0, textColor: UIColor.darkGrayColor(), textAlignment: .Center, numberOfLines: 0)

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
