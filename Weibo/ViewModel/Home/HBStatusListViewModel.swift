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
    var statusList: [HBStatusModel] = [HBStatusModel]()

    override init() {

    }

    // 网络加载数据
    func loadData(since_id: Int, max_id: Int, success: ()->(), failure: ()->()) {
        guard let access_token = HBOauthViewModel.sharedInstance.access_token else {
            return;
        }

        let params = ["access_token" : access_token, "since_id" : since_id, "max_id" : max_id]
        HBHTTPClient.request(.GET, URLString: "https://api.weibo.com/2/statuses/home_timeline.json", parameters: params, success: { (JSON) in
            // 遍历数组, 字典转模型, 然后添加到微博数组

            guard let json = JSON as? [String : AnyObject] else {
                return
            }
            guard let statuses = json["statuses"] as? [[String : AnyObject]] else {
                return
            }
            for status in statuses {
                let model = HBStatusModel(dict: status)
                self.statusList.append(model)
            }

            success()

            }) { (error) in
                printLog(error)
                failure()
        }
    }
}
