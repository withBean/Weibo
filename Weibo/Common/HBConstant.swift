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
