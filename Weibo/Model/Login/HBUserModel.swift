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
//    var expires_in: String?   // 此处文档有误, 如果发现后台返回的数据类型/数据格式/数据字段不够/添加数据字段等等任何关于数据的问题, 应第一时间找后台
    var expires_date: NSDate?   // 定义一个时间, expires_date == 现在时间 + expires_in
    var expires_in: NSTimeInterval = 0 {
        didSet {
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    var remind_in: String?
    var uid: String?
    var screen_name: String?
    var profile_image_url: String?

    // 字典转模型
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }

    // MARK: - 归档和解档
    // encode, 对象转换为二进制文件
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expires_in, forKey: "expires_in")
        aCoder.encodeObject(remind_in, forKey: "remind_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
        aCoder.encodeObject(profile_image_url, forKey: "profile_image_url")
    }

    // decode, 二进制文件转换为对象
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSTimeInterval ?? 0
        remind_in = aDecoder.decodeObjectForKey("remind_in") as? String
        uid = aDecoder.decodeObjectForKey("uid") as? String
        screen_name = aDecoder.decodeObjectForKey("screen_name") as? String
        profile_image_url = aDecoder.decodeObjectForKey("profile_image_url") as? String
    }

    // Archiver
    func saveUserModel() {
        // 拼接文件路径   // stringbyappending 是NSString的方法,我们需要把 String 转换成NSString
        let docPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!
        let filePath = (docPath as NSString).stringByAppendingPathComponent("userInfo.plist")
        // 归档
        NSKeyedArchiver.archiveRootObject(self, toFile: filePath)
    }

    // unarchiver, 类方法方便调用
    class func readUserInfo() -> HBUserModel? {
        let docPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!
        let filePath = (docPath as NSString).stringByAppendingPathComponent("userInfo.plist")
        // 解档
        let model = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? HBUserModel

        // 时效性判断 
        // 定义一个时间, expires_date == 现在时间 + expires_in
        // (若expires_date > 当前时间, 降序, 说明在有效期内)
        if let date = model?.expires_date {
            if date.compare(NSDate()) == NSComparisonResult.OrderedDescending {
                return model
            } else {
                return nil
            }
        }

        return model
    }
}

/*
返回值字段	字段类型	字段说明
id	int64	用户UID
idstr	string	字符串型的用户UID
screen_name	string	用户昵称
name	string	友好显示名称
province	int	用户所在省级ID
city	int	用户所在城市ID
location	string	用户所在地
description	string	用户个人描述
url	string	用户博客地址
profile_image_url	string	用户头像地址（中图），50×50像素
profile_url	string	用户的微博统一URL地址
domain	string	用户的个性化域名
weihao	string	用户的微号
gender	string	性别，m：男、f：女、n：未知
followers_count	int	粉丝数
friends_count	int	关注数
statuses_count	int	微博数
favourites_count	int	收藏数
created_at	string	用户创建（注册）时间
following	boolean	暂未支持
allow_all_act_msg	boolean	是否允许所有人给我发私信，true：是，false：否
geo_enabled	boolean	是否允许标识用户的地理位置，true：是，false：否
verified	boolean	是否是微博认证用户，即加V用户，true：是，false：否
verified_type	int	暂未支持
remark	string	用户备注信息，只有在查询用户关系时才返回此字段
status	object	用户的最近一条微博信息字段 详细
allow_all_comment	boolean	是否允许所有人对我的微博进行评论，true：是，false：否
avatar_large	string	用户头像地址（大图），180×180像素
avatar_hd	string	用户头像地址（高清），高清头像原图
verified_reason	string	认证原因
follow_me	boolean	该用户是否关注当前登录用户，true：是，false：否
online_status	int	用户的在线状态，0：不在线、1：在线
bi_followers_count	int	用户的互粉数
lang	string	用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语
*/