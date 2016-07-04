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

    // (1) 定义成员变量vc, 用来接收控制器 (以便跳转到其它vc)
    var viewController: UIViewController?

    // 存放按钮, 方便管理
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

        UIView.animateWithDuration(0.3, animations: { () -> Void in
            // 被点击按钮放大, 其它缩小. 同时渐变透明消失
            for obj in self.composeBtns {
                obj.alpha = 0.0
                if obj == button {
                    obj.transform = CGAffineTransformMakeScale(2.0, 2.0)
                } else {
                    obj.transform = CGAffineTransformMakeScale(0.25, 0.25)
                }
            }

            }) { (_) -> Void in
                // 动画完成后进行页面跳转 {通知/代理/闭包, 这里采用对象传值 -- showButtonAnimation中传过来targetVc}
                let nav = UINavigationController(rootViewController: HBComposeTextController())
                self.viewController?.presentViewController(nav, animated: true, completion: nil)
        }

    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 反向遍历 (与显示时的动画效果相反)
        for (index, button) in composeBtns.reverse().enumerate() {
            buttonSpringAnimation(button, time: CACurrentMediaTime() + 0.05 * Double(index), type: .Down)
        }
        // 延迟remove, 否则看不到动画效果
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.05 * Double(composeBtns.count) * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            self.removeFromSuperview()
        }
    }

    private func buttonSpringAnimation(button: UIButton, time: CFTimeInterval, type: ComposeAnimationType) {
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

    private func showComposeButtonAnimation() {
        // 遍历设置动画
        for (index, button) in composeBtns.enumerate() {
            buttonSpringAnimation(button, time: CACurrentMediaTime() + 0.05 * Double(index), type: .Up)
        }
    }

    // 提供的对外接口, 类方法
    class func addComposeViewWithButtonAnimation(targetVC: UIViewController) {
        // 添加本view
        let composeView = HBComposeView()
        targetVC.view.addSubview(composeView)
        composeView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight)
        composeView.showComposeButtonAnimation()

        // 对象传值, 以便跳转到其它vc
        composeView.viewController = targetVC
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
