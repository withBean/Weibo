//
//  HBStatusModel.swift
//  Weibo
//
//  Created by Beans on 16/7/13.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

class HBStatusModel: NSObject {

    var created_at: String?
    var id: Int = 0
    var text: String?
    var source: String?

    var reposts_count: Int = 0
    var comments_count: Int = 0
    var attitudes_count: Int = 0

    var user: HBStatusUserModel?
    var retweeted_status: HBStatusModel?
    var pic_urls: [HBStatusPictureModel]?

    // 构造函数
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)

        // user嵌套字典转模型
        if let userDict = dict["user"] as? [String : AnyObject] {
            user = HBStatusUserModel(dict: userDict)
        }

        // retweeted_status嵌套字典转模型
        if let retweeted_statusDict = dict["retweeted_status"] as? [String : AnyObject] {
            retweeted_status = HBStatusModel(dict: retweeted_statusDict)
        }

        // pic_urls嵌套数组 (MVC)
        if let pic_urlsArr = dict["pic_urls"] as? [[String : AnyObject]] {
            // 一定要注意: 属性数组要先完成初始化 /* fatal error: NSArray element failed to match the Swift Array Element type */
            pic_urls = [HBStatusPictureModel]()

            // 遍历数组, 字典转模型
            for pic_urlDict in pic_urlsArr {
                let picModel = HBStatusPictureModel(dict: pic_urlDict)
                // 添加到数组
                pic_urls?.append(picModel)
            }
        }

//        // pic_urls嵌套数组 (MVVM)
//        if let pic_urlsArr = dict["pic_urls"] as? [[String : AnyObject]] {
//            // 一定要注意: 属性数组要先完成初始化
//            pic_urls = [HBStatusPictureViewModel]()
//
//            // 遍历数组, 字典转模型
//            for pic_urlDict in pic_urlsArr {
//                let picModel = HBStatusPictureModel(dict: pic_urlDict)
//                let viewModel = HBStatusPictureViewModel(model: picModel)
//                // 添加到数组
//                pic_urls?.append(viewModel)
//            }
//        }
    }

    // 防崩溃
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
}

/*
 statuses/home_timeline
 获取当前登录用户及其所关注（授权）用户的最新微博
 URL: https://api.weibo.com/2/statuses/home_timeline.json
 支持格式: JSON
 HTTP请求方式: GET

 请求参数
 必选	类型及范围	说明
 access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
 since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 count	false	int	单页返回的记录条数，最大不超过100，默认为20。
 page	false	int	返回结果的页码，默认为1。
 base_app	false	int	是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 feature	false	int	过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 trim_user	false	int	返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。

 注意事项
 只返回授权用户的微博，非授权用户的微博将不返回；
 例如一次调用total_number是50，但其中授权用户发的只有10条，则实际只返回10条微博；
 使用官方移动SDK调用，可多返回30%的非授权用户的微博
 
 返回字段说明
 返回值字段	字段类型	字段说明
 created_at	string	微博创建时间
 id	int64	微博ID
 mid	int64	微博MID
 idstr	string	字符串型的微博ID
 text	string	微博信息内容
 source	string	微博来源
 favorited	boolean	是否已收藏，true：是，false：否
 truncated	boolean	是否被截断，true：是，false：否
 in_reply_to_status_id	string	（暂未支持）回复ID
 in_reply_to_user_id	string	（暂未支持）回复人UID
 in_reply_to_screen_name	string	（暂未支持）回复人昵称
 thumbnail_pic	string	缩略图片地址，没有时不返回此字段
 bmiddle_pic	string	中等尺寸图片地址，没有时不返回此字段
 original_pic	string	原始图片地址，没有时不返回此字段
 geo	object	地理信息字段 详细
 user	object	微博作者的用户信息字段 详细
 retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
 reposts_count	int	转发数
 comments_count	int	评论数
 attitudes_count	int	表态数
 mlevel	int	暂未支持
 visible	object	微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
 pic_ids	object	微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
 ad	object array	微博流内的推广微博ID
 */