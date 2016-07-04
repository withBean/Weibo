//
//  HBComposeView.swift
//  Weibo
//
//  Created by Beans on 16/7/1.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

enum ComposeAnimationType: Int {
    case Up = 0
    case Down = 1
    case Left = 2
    case Right = 3
}

class HBComposeView: UIView {

    // 存放按钮
    private lazy var composeBtns: [UIButton] = [UIButton]()

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
        let btnW: CGFloat = 80
        let btnH: CGFloat = 100
        let colCount = 3
        let leftMargin: CGFloat = 40
        let margin: CGFloat = (kScreenWidth - btnW * CGFloat(colCount) - leftMargin * 2) / CGFloat(colCount - 1)
        let topMargin: CGFloat = 250

        let composeArr = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("composeBtn.plist", ofType: nil)!)!
        for i in 0..<composeArr.count {
            let titleStr = composeArr[i]["title"] as! String    // as! 只要敢保证数据有值且类型正确
            let imgStr = composeArr[i]["icon"] as! String
            let button = HBComposeButton(title: titleStr, titleColor: UIColor.darkGrayColor(), image: imgStr)

            let col = i % colCount
            let row = i / colCount
            let btnX: CGFloat = leftMargin + (btnW + margin) * CGFloat(col)
            let btnY: CGFloat = topMargin + (btnH + margin) * CGFloat(row)
            button.frame = CGRectMake(btnX, btnY, btnW, btnH)

            button.addTarget(self, action: "composeBtnClick:", forControlEvents: .TouchUpInside)
//            bgImgView.addSubview(button)
            addSubview(button)
            composeBtns.append(button)
        }
    }

    @objc private func composeBtnClick(button: HBComposeButton) {
        printLog("composeBtnClick")
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.removeFromSuperview()
    }

    private func buttonAnimation(button: UIButton, time: CFTimeInterval, type: ComposeAnimationType) {
//        // 创建springAnim
//        let anim = POPSpringAnimation(propertyNamed: kPOPViewCenter)
//        // 修改toValue, 让视图到指定的位置
//        if type == .Up {            // 向上
//            anim.toValue = NSValue(CGPoint: CGPointMake(button.center.x, button.center.y - kScreenHeight + 300))
//        } else if type == .Down {   // 向下
//            anim.toValue = NSValue(CGPoint: CGPointMake(button.center.x, button.center.y + kScreenHeight))
//        }
//        // 弹性反弹
//        anim.springBounciness = 4
//        // 设置springSpeed
//        anim.springSpeed = 10
//        // 开始时间
//        anim.beginTime = time
//        // 添加动画
//        button.pop_addAnimation(anim, forKey: nil)
    }

    private func showButtonAnimation() {
        for (index, button) in composeBtns.enumerate() {
            buttonAnimation(button, time: CACurrentMediaTime() + 0.25 * Double(index), type: .Up)
        }
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
