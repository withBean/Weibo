//
//  HBComposeView.swift
//  Weibo
//
//  Created by Beans on 16/7/1.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

class HBComposeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = color_HSB_Random()

        addSubview(bgImgView)
        bgImgView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }

        addButtons()
    }

    private func addButtons() {
       

        let button = HBComposeButton(title: "相机", titleColor: UIColor.darkGrayColor(), image: "tabbar_compose_lbs")
        button.sizeToFit()
        button.frame = CGRectMake(0, 0, 80, 110)
        bgImgView.addSubview(button)
    }

    private func buttonAnimation() {

    }

    private func showButtonAnimation() {

    }

    // 提供的带外接口, 类方法
    class func showButtonAnimation() {

        HBComposeView().showButtonAnimation()
    }

    private lazy var bgImgView: UIImageView = {
        // 当前屏幕截图
        let imgV = UIImageView(image: UIImage.getScreenShot())

        // 毛玻璃效果
        let effect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let effectView = UIVisualEffectView(effect: effect)
        imgV.addSubview(effectView)
        effectView.snp_makeConstraints(closure: { (make) -> Void in
            make.edges.equalTo(imgV)
        })

        return imgV
    }()
}
