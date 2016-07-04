//
//  UIButton+HBExtension.swift
//  Weibo
//
//  Created by Beans on 16/6/28.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

extension UIButton {
//    convenience init(title: String, titleColor: UIColor, image: String, backgroundImage: String, backgroundColor: UIColor, target: String) {
//        self.init()
//
//        self.setTitle(title, forState: .Normal)
//        self.setTitleColor(titleColor, forState: .Normal)
//        self.setImage(UIImage(named: image), forState: .Normal)
//        self.setBackgroundImage(UIImage(named: backgroundImage), forState: .Normal)
//        self.backgroundColor = backgroundColor
//        self.addTarget(self, action: Selector(target), forControlEvents: .TouchUpInside)    // Selector, 仍然有问题
//    }

//    convenience init(title: String, titleColor: UIColor, target: String) {
//        self.init()
//
//        self.setTitle(title, forState: .Normal)
//        self.setTitleColor(titleColor, forState: .Normal)
//        self.addTarget(self, action: Selector(target), forControlEvents: .TouchUpInside)    // Selector, 仍然有问题
//    }

//    convenience init(image: String, backgroundImage: String, target: String) {
//        self.init()
//
//        self.setImage(UIImage(named: image), forState: .Normal)
//        self.setBackgroundImage(UIImage(named: backgroundImage), forState: .Normal)
//        self.addTarget(self, action: Selector(target), forControlEvents: .TouchUpInside)    // Selector, 仍然有问题
//    }

    convenience init(title: String, titleColor: UIColor, image: String, backgroundImage: String, backgroundColor: UIColor) {
        self.init()

        self.setTitle(title, forState: .Normal)
        self.setTitleColor(titleColor, forState: .Normal)
        self.setImage(UIImage(named: image), forState: .Normal)
        self.setBackgroundImage(UIImage(named: backgroundImage), forState: .Normal)
        self.backgroundColor = backgroundColor
        self.sizeToFit()
    }

    convenience init(title: String, titleColor: UIColor, image: String) {
        self.init()

        self.setTitle(title, forState: .Normal)
        self.setImage(UIImage(named: image), forState: .Normal)
        self.setTitleColor(titleColor, forState: .Normal)
        self.sizeToFit()
    }

}