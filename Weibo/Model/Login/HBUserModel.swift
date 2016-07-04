//
//  HBUserModel.swift
//  Weibo
//
//  Created by Beans on 16/7/4.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

/*
access_token	string	用户授权的唯一票据，用于调用微博的开放接口，同时也是第三方应用验证微博用户登录的唯一票据，第三方应用应该用该票据和自己应用内的用户建立唯一影射关系，来识别登录状态，不能使用本返回值里的UID字段来做登录识别。
expires_in	string	access_token的生命周期，单位是秒数。
remind_in	string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
uid	string	授权用户的UID，本字段只是为了方便开发者，减少一次user/show接口调用而返回的，第三方应用不能用此字段作为用户登录状态的识别，只有access_token才是用户授权的唯一票据。
*/
class HBUserModel: NSObject {

    var access_token: String?
//    var expires_in: String?   // 此处文档有误
    //  如果发现后台返回的数据类型/数据格式/数据字段不够/添加数据字段等等任何关于数据的问题,第一时间找后台
    var expires_in: NSTimeInterval = 0
    var remind_in: String?
    var uid: String?

    // 字典转模型
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
}
