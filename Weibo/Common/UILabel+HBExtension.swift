//
//  UILabel+HBExtension.swift
//  Weibo
//
//  Created by Beans on 16/6/28.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

/*
通过便利构造函数 来扩展UIImage的构造函数

便利构造函数:
1. convenience
2. 要借助于其它构造函数
3. 不能调用super
*/

extension UILabel {
    convenience init(text: String, fontSize: CGFloat, textColor: UIColor, textAlignment: NSTextAlignment, numberOfLines: Int) {
        self.init()  // 千万不能用super

        self.text = text
        self.font = UIFont.systemFontOfSize(fontSize)
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}