//
//  UIImage+HBExtension.swift
//  Weibo
//
//  Created by Beans on 16/7/1.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

extension UIImage {

    /// 获取当前屏幕截图
    class func getScreenShot() -> UIImage {
        // 1. 获取当前window
        let window = UIApplication.sharedApplication().keyWindow!
        // 2. 开启绘图
        // size: 大小; opaque: 是否透明; scale: 缩放系数
        UIGraphicsBeginImageContextWithOptions(kScreenSize, false, 1.0)
        // 3. 把window画在画板上
        window.drawViewHierarchyInRect(kScreenBounds, afterScreenUpdates: false)
        // 4. 拿到image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // 5. 关闭画板
        UIGraphicsEndImageContext()

        return image
    }


    /// stretchable方式切图
    class func stretchImageWithImageName(imgName: String) -> UIImage {
        let image: UIImage = UIImage(named: imgName) ?? UIImage()
        return image.stretchableImageWithLeftCapWidth(Int(Double(image.size.width) * 0.5), topCapHeight: Int(Double(image.size.height) * 0.5))
    }

    /// resizable方式切图
    class func resizeImageWithImageName(imgName: String) -> UIImage {
        let image: UIImage = UIImage(named: imgName) ?? UIImage()
        return image.resizableImageWithCapInsets(UIEdgeInsetsMake(image.size.height * 0.5, image.size.width * 0.5, image.size.height * 0.5, image.size.width * 0.5))
    }
}

// 默认图片
//let imgDefault = UIImage(named: "photo_define")
//let imgPlaceHolder = UIImage(named: "placeholder")
