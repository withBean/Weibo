//
//  HBOauthViewModel.swift
//  Weibo
//
//  Created by Beans on 16/7/4.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

/** MVVM的原则:
 1. view和ViewController结合在了一起
 2. view和ViewController不能喝Model进行交互, 需要和viewModel进行交互
 3. viewModel对上需要的View和ViewController交互, 对下需要和Model交互

 viewModel放哪些东西?
 1. 和Model打交道
 2. 所有网络请求需要放在这里
 3. 对数据的处理
 */

 /*
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致
 */
class HBOauthViewModel: NSObject {

    // 定义为单例, 方便外界调用, 同时返回的数据指向同一块内存区域
    static let sharedInstance: HBOauthViewModel = HBOauthViewModel()

    var userModel: HBUserModel?

    // 直接把userModel的属性access_token放在viewModel中, 方便用户调用
    var access_token: String? {
        return userModel?.access_token
    }

    // MARK: - 用code来获取token
    func loadToken(code: String, success: ()->(), failure: ()->()) {

        let params = [
                "client_id" : AppKey,
            "client_secret" : AppSecret,
               "grant_type" : "authorization_code",
                     "code" : code,
             "redirect_uri" : AppRedirectURI
        ]
        
        HBHTTPClient.request(.POST, URLString: "https://api.weibo.com/oauth2/access_token", parameters: params, success: { (JSON) -> Void in
            printLog(JSON)
            success()
            /*
            "access_token" = "2.00rKqTjCXublFD887f1561155P8HSB";
            "expires_in" = 157679999;
            "remind_in" = 157679999;
            uid = 2504312857;
            */

            // 问题: AnyObject? 不能放在字典里
            // 解决思路: 对 AnyObject? 进行转换
            if let jsonDict = JSON as? [String : AnyObject] {
                let model = HBUserModel(dict: jsonDict)
                printLog(model.access_token)
            }

            }) { (error) -> Void in
                printLog(error)
                failure()
        }
    }
}
