//
//  HBStatusCellViewModel.swift
//  Weibo
//
//  Created by Beans on 16/7/13.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

class HBStatusCellViewModel: NSObject {
    
    var model: HBStatusModel?
    init(model: HBStatusModel) {
        self.model = model
    }

    // MARK: - 原创微博数据处理
    var userIcon: NSURL? {
        if let urlString = model?.user?.profile_image_url {
            return NSURL(string: urlString)
        }
        return NSURL()
    }

    var userName: String? {
        return model?.user?.screen_name
    }

    var vipIcon: UIImage? {
        if let level = model?.user?.mbrank {
            return UIImage(named: "common_icon_membership_level\(level)")
        }
        return UIImage()
    }

    /// 认证类型 -1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    var verifyIcon: UIImage? {
        if let type = model?.user?.verified_type {
            switch type {
            case -1:
                return UIImage()
            case 0:
                return UIImage(named: "avatar_grassroot")
            case 2,3,5:
                return UIImage(named: "avatar_enterprise_vip")
            case 220:
                return UIImage(named: "avatar_vip")
            default:
                return UIImage()
            }
        }
        return UIImage()
    }

    var releaseTime: String? {
        return model?.created_at
    }

    var releaseSource: String? {
        return model?.source
    }

    var blogContent: String? {
        return model?.text
    }

    // MARK: - 底部转发/评论/点赞工具栏数据处理
    var repostCount: String? {
        if model?.reposts_count == 0 {
            return " 转发"    // 来个空格
        } else {
            return " \(model?.reposts_count ?? 0)"  // 本来不需解包, 但显示结果为`Optional(12)`
        }
    }

    var commentCount: String? {
        if model?.comments_count == 0 {
            return " 评论"
        } else {
            return " \(model?.comments_count ?? 0)"
        }
    }

    var attitudeCount: String? {
        if model?.attitudes_count == 0 {
            return " 点赞"
        } else {
            return " \(model?.attitudes_count ?? 0)"
        }
    }
}
