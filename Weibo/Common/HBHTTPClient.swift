//
//  HBHTTPClient.swift
//  Weibo
//
//  Created by Beans on 16/7/4.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

enum ClientType: String {
    case GET = "GET"
    case POST = "POST"
}

class HBHTTPClient: AFHTTPSessionManager {

    static let sharedInstance: HBHTTPClient = {
        let client = HBHTTPClient()
        // 网络请求的客户端不能识别 text/plain, 需要设置才能对数据进行解析
        client.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return client
    }()

    // 单例, 对外隐藏
    private init() {
        // 须调用指定的构造函数
        super.init(baseURL: nil, sessionConfiguration: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    // 将 GET和POST 合并成一个方法
//    func request(type: ClientType, URLString: String, parameters: AnyObject?, success: ((NSURLSessionDataTask, AnyObject?) -> Void)?, failure: ((NSURLSessionDataTask?, NSError) -> Void)?) {
//        if type == .GET {
//            GET(URLString, parameters: parameters, success: success, failure: failure)
//        } else if type == .POST {
//            POST(URLString, parameters: parameters, success: success, failure: failure)
//        }
//    }

    // 对象方法
    func request(type: ClientType, URLString: String, parameters: AnyObject?, success: AnyObject? -> Void, failure: NSError -> Void) {
        // 去掉 NSURLSessionDataTask
        let success = { (task: NSURLSessionDataTask, json: AnyObject?) -> Void in
            success(json)
        }
        let failure = { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            failure(error)
        }

        // 将 GET和POST 合并成一个方法
        if type == .GET {
            GET(URLString, parameters: parameters, success: success, failure: failure)
        } else if type == .POST {
            POST(URLString, parameters: parameters, success: success, failure: failure)
        }
    }

    // 类方法
    class func request(type: ClientType, URLString: String, parameters: AnyObject?, success: AnyObject? -> Void, failure: NSError -> Void) {
        // 单例调用对象方法
        sharedInstance.request(type, URLString: URLString, parameters: parameters, success: success, failure: failure)
    }
}
