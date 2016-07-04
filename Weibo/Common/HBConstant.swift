//
//  HBConstant.swift
//  sinaWeibo
//
//  Created by Beans on 16/6/24.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

///  输出日志
///
///  - parameter message:  日志消息
///  - parameter logError: 错误标记. 默认false, 如果是true, 发布时仍然会输出
///  - parameter file:     文件名
///  - parameter method:   方法名
///  - parameter line:     代码行数
func printLog<T>(message: T,
    logError: Bool = false,
    file: String = __FILE__,
    method: String = __FUNCTION__,
    line: Int = __LINE__)
{
    if logError {
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    } else {
        #if DEBUG
            print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        #endif
    }
}

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 开发账号相关 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

// MARK:--申请的账号信息
let AppKey = "2833627325"
let AppSecret = "cc0d89ccb25713565650ab18898e3d82"
let AppRedirectURI = "https://github.com/withBean"
// 取消授权回调页：http://weibo.com/troiscouleurs

// 用于申请的开发者信息
let userId = "troiscouleurs@163.com"
let passwd = "weiOu@423622"

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 我的工具 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

let kScreenBounds = UIScreen.mainScreen().bounds
let kScreenSize   = UIScreen.mainScreen().bounds.size
let kScreenWidth  = UIScreen.mainScreen().bounds.size.width
let kScreenHeight = UIScreen.mainScreen().bounds.size.height

let kStatusBarH = 20
let kNavBarHeight = 44  // 64 = 20 + 44
let kNavBarH_LandScape = 32
let kNavBarH_Prompt = 74
let kNavBarIconWH = 20
let kTabBarHeight = 44  // 49?
let kTabBarH_LandScape = 32
let kTabBarIconWH = 30
let kSegmentCtrlH = 44
let kKeyBoardH = 216    // 252
let kKeyBoardH_LandScape = 162  // 198
let kPickerViewH = 216

let kMargin_5 : CGFloat = 5
let kMargin_8 : CGFloat = 8
let kMargin_10: CGFloat = 10
let kMargin_20: CGFloat = 20

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 华丽的分割线 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

let kKeyWindow =  UIApplication.sharedApplication().keyWindow      // addSubview & bringSubviewToFront

let version = (UIDevice.currentDevice().systemVersion as NSString).floatValue
let IS_IOS7 = (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 7.0
let IS_IOS8 = (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0

//判断是不是plus
let currentModeSize = UIScreen.mainScreen().currentMode?.size
let isPlus = UIScreen.instancesRespondToSelector("currentMode") ? CGSizeEqualToSize(CGSizeMake(1242, 2208), currentModeSize!) : false

//判断字符串是否为空
func trimString(str:String)->String{
    let nowStr = str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    return nowStr
}
//去除空格和回车
func trimLineString(str:String)->String{
    let nowStr = str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    return nowStr
}
//消息提醒
func showAlertView(title: String, message: String, btnTitle: String)
{
    let alert = UIAlertView()
    alert.title = title
    alert.message = message
    alert.addButtonWithTitle(btnTitle)
    alert.show()
}

// 通知中心
let notiCenter = NSNotificationCenter.defaultCenter()
// NSUserDefault
let userDefault = NSUserDefaults.standardUserDefaults()
//获取本地存储数据
func get_userDefaults(key : String) -> AnyObject? {
    var saveStr : AnyObject! = userDefault.objectForKey(key)
    saveStr = (saveStr == nil) ? "" : saveStr
    return saveStr
}
//存储数据
func save_userDefaults(key: String, value: AnyObject?) {
    userDefault.setObject(value!, forKey:key)
}

// frame相关
func x(obj: UIView)->CGFloat {
    return obj.frame.origin.x
}
func y(obj: UIView)->CGFloat {
    return obj.frame.origin.y
}
func w(obj: UIView)->CGFloat {
    return obj.frame.size.width
}
func h(obj: UIView)->CGFloat {
    return obj.frame.size.height
}



/** 待完善的

 数据源/代理
 注册
 AppDelegate

 */

 ///  计算字符串真实尺寸
 ///
 ///  - parameter text:     要计算的文字
 ///  - parameter textFont: 计算时用到的字体
 ///  - parameter maxSize:  规定的最大尺寸 (水平和竖直限制)
func sizeWithText(text: String, textFont: UIFont, maxSize: CGSize) -> CGSize {
    let attr: [String : AnyObject] = [NSFontAttributeName : textFont]
    return text.boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attr, context: nil).size
}

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 丑陋的分割线 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

//// 0～(x-1)
//func getRandomNumber(x: Int) -> Int {
//    return Int(arc4random()) % x
//}

// arc4random_uniform会随机返回一个0到上界之间(不含上界)的整数. 以2为上界会得到0或1, 像投硬币一样
func getRandomNumber(from: Int = 0, to: Int) -> Int {
    return Int(arc4random()) % (to - from + 1) + from
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * about color * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/// RGB
func colorWithRGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
    let base: CGFloat = 256.0
    return UIColor(red: red/base, green: green/base, blue: blue/base, alpha: alpha)
}

///  HSB
///  - parameter H: 0°~360° (色相)
///  - parameter S: 0~100%  (饱和度)
///  - parameter B: 0~100%  (亮度)
///  - parameter A: 0~1
func colorWithHSB(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
    return UIColor(hue: hue/360.0, saturation: saturation/100.0, brightness: brightness/100.0, alpha: alpha)
}

/// hex
func colorWithHex(hex: Int, alpha: Float = 1.0) -> UIColor {
    let blue = hex & 0xFF
    let green = (hex >> 8) & 0xFF
    let red = (hex >> 16) & 0xFF
    return colorWithRGB(CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
}

/// hexString
func colorWithHexString(hexString: String, alpha: Float = 1.0) -> UIColor {
    var hexStr = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
    if (hexStr.hasPrefix("#")) {
        hexStr = (hexStr as NSString).substringFromIndex(1)
    }
    var hex:CUnsignedInt = 0
    NSScanner.init(string: hexStr).scanHexInt(&hex)  // Optionally prefixed with "0x" or "0X"

    let blue = hex & 0xFF
    let green = (hex >> 8) & 0xFF
    let red = (hex >> 16) & 0xFF
    return colorWithRGB(CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
}

/// randomColor
func color_HSB_Random() -> UIColor {
    let hue = (CGFloat(arc4random()) % 256 / 256.0)               //  0.0 to 1.0
    let saturation = (CGFloat(arc4random()) % 128 / 256.0) + 0.5  //  0.5 to 1.0, away from white
    let brightness = (CGFloat(arc4random()) % 128 / 256.0) + 0.5  //  0.5 to 1.0, away from black
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
}

func color_RGB_Random() -> UIColor {
    return UIColor(red: (CGFloat(arc4random_uniform(256)) / 256.0), green: (CGFloat(arc4random_uniform(256)) / 256.0), blue: (CGFloat(arc4random_uniform(256)) / 256.0), alpha: 1.0)
}

/*----------------------------- end -----------------------------*/
