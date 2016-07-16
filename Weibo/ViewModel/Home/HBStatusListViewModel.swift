//
//  HBStatusListViewModel.swift
//  Weibo
//
//  Created by Beans on 16/7/13.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

class HBStatusListViewModel: NSObject {

    static let sharedInstance: HBStatusListViewModel = HBStatusListViewModel()
    // 微博数组
    var statusList: [HBStatusCellViewModel] = [HBStatusCellViewModel]()     // 改为viewModel

    override init() {

    }

    // 网络加载数据
    func loadData(since_id: Int, max_id: Int, success: ()->(), failure: ()->()) {
        guard let access_token = HBOauthViewModel.sharedInstance.access_token else {
            return;
        }

        let params = ["access_token" : access_token, "since_id" : since_id, "max_id" : max_id]
        HBHTTPClient.request(.GET, URLString: "https://api.weibo.com/2/statuses/home_timeline.json", parameters: params, success: { (JSON) in
//            printLog(JSON)

            // 遍历数组, 字典转模型, 然后添加到微博数组

            guard let json = JSON as? [String : AnyObject] else {
                return
            }
            guard let statuses = json["statuses"] as? [[String : AnyObject]] else {
                return
            }
            for status in statuses {
//                printLog(status)
                let model = HBStatusModel(dict: status)
                self.statusList.append(HBStatusCellViewModel(model: model)) // viewModel
            }

            success()

            }) { (error) in
                printLog(error)
                failure()
        }
    }
}


/*
["mlevel": 0, "text_tag_tips": <__NSArray0 0x7f88e1600180>(

    )
    , "in_reply_to_user_id": , "original_pic": http://ww4.sinaimg.cn/large/90d487bbgw1f5udi1254gj20qb0zk41k.jpg, "bmiddle_pic": http://ww4.sinaimg.cn/bmiddle/90d487bbgw1f5udi1254gj20qb0zk41k.jpg, "userType": 0, "annotations": <__NSCFArray 0x7f88e1546710>(
    {
    "client_mblogid" = "e97ea84f-ad1a-48e9-9fb8-fb90a5a52901";
    },
    {
    "mapi_request" = 1;
    }
    )
    , "in_reply_to_status_id": , "pic_urls": <__NSCFArray 0x7f88e153a7c0>(
    {
    "thumbnail_pic" = "http://ww4.sinaimg.cn/thumbnail/90d487bbgw1f5udi1254gj20qb0zk41k.jpg";
    },
    {
    "thumbnail_pic" = "http://ww2.sinaimg.cn/thumbnail/90d487bbgw1f5udi1qlk7j20qb0zk0xe.jpg";
    },
    {
    "thumbnail_pic" = "http://ww2.sinaimg.cn/thumbnail/90d487bbgw1f5udi2cmgkj20qb0zkgrk.jpg";
    },
    {
    "thumbnail_pic" = "http://ww1.sinaimg.cn/thumbnail/90d487bbgw1f5udi3jxu0j20qb0zkgs0.jpg";
    },
    {
    "thumbnail_pic" = "http://ww2.sinaimg.cn/thumbnail/90d487bbgw1f5udi4fodij20qb0zk7bc.jpg";
    },
    {
    "thumbnail_pic" = "http://ww1.sinaimg.cn/thumbnail/90d487bbgw1f5udi5420oj20qb0zkn5i.jpg";
    },
    {
    "thumbnail_pic" = "http://ww3.sinaimg.cn/thumbnail/90d487bbgw1f5udi6bby0j20qb0zkahn.jpg";
    },
    {
    "thumbnail_pic" = "http://ww3.sinaimg.cn/thumbnail/90d487bbgw1f5udi7glkpj20qb0zkqdr.jpg";
    },
    {
    "thumbnail_pic" = "http://ww4.sinaimg.cn/thumbnail/90d487bbgw1f5udi8fufwj20qb0zkqbr.jpg";
    }
    )
    , "cardid": vip_009, "favorited": 0, "hot_weibo_tags": <__NSArray0 0x7f88e1600180>(

    )
    , "id": 3997879977097052, "text": #每天画唠# @安再哉 迷鹿[微风][微风][微风], "source_allowclick": 0, "rid": 0_0_1_2666871603635262132, "visible": {
        "list_id" = 0;
        type = 0;
}, "geo": <null>, "user": {
    "allow_all_act_msg" = 1;
    "allow_all_comment" = 1;
    "avatar_hd" = "http://tva4.sinaimg.cn/crop.0.0.180.180.1024/90d487bbjw1e8qgp5bmzyj2050050aa8.jpg";
    "avatar_large" = "http://tva4.sinaimg.cn/crop.0.0.180.180.180/90d487bbjw1e8qgp5bmzyj2050050aa8.jpg";
    "bi_followers_count" = 172;
    "block_app" = 1;
    "block_word" = 0;
    cardid = "vip_009";
    city = 1;
    class = 1;
    "cover_image_phone" = "http://ww2.sinaimg.cn/crop.0.0.640.640.640/638f41a8jw1exw1bkizguj20hs0hsgoy.jpg";
    "created_at" = "Thu Oct 27 13:57:03 +0800 2011";
    "credit_score" = 80;
    description = "\U753b\U753b\U662f\U4e00\U79cd\U4fe1\U4ef0\Uff01";
    domain = "";
    "favourites_count" = 677;
    "follow_me" = 0;
    "followers_count" = 1769658;
    following = 1;
    "friends_count" = 362;
    gender = f;
    "geo_enabled" = 1;
    id = 2429847483;
    idstr = 2429847483;
    lang = "zh-cn";
    location = "\U6c5f\U82cf \U5357\U4eac";
    mbrank = 6;
    mbtype = 12;
    name = "\U63d2\U753b\U89c6\U89c9";
    "online_status" = 0;
    "pagefriends_count" = 60;
    "profile_image_url" = "http://tva4.sinaimg.cn/crop.0.0.180.180.50/90d487bbjw1e8qgp5bmzyj2050050aa8.jpg";
    "profile_url" = 274433040;
    province = 32;
    ptype = 0;
    remark = "";
    "screen_name" = "\U63d2\U753b\U89c6\U89c9";
    star = 0;
    "statuses_count" = 13707;
    urank = 37;
    url = "";
    "user_ability" = 12;
    verified = 1;
    "verified_contact_email" = "";
    "verified_contact_mobile" = "";
    "verified_contact_name" = "";
    "verified_level" = 3;
    "verified_reason" = "\U5fae\U535a\U8bbe\U8ba1\U7f8e\U5b66\U5e10\U53f7";
    "verified_reason_modified" = "";
    "verified_reason_url" = "";
    "verified_source" = "";
    "verified_source_url" = "";
    "verified_state" = 0;
    "verified_trade" = 3569;
    "verified_type" = 0;
    "verified_type_ext" = 0;
    weihao = 274433040;
}, "biz_feature": 4294967300, "created_at": Sat Jul 16 14:58:46 +0800 2016, "positive_recom_flag": 0, "truncated": 0, "comments_count": 0, "idstr": 3997879977097052, "mid": 3997879977097052, "darwin_tags": <__NSArray0 0x7f88e1600180>(

)
, "in_reply_to_screen_name": , "source": , "thumbnail_pic": http://ww4.sinaimg.cn/thumbnail/90d487bbgw1f5udi1254gj20qb0zk41k.jpg, "textLength": 41, "reposts_count": 0, "isLongText": 0, "page_type": 32, "source_type": 2, "attitudes_count": 20]

 */
