//
//  HBOauthViewModel.swift
//  Weibo
//
//  Created by Beans on 16/7/4.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

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

import UIKit

class HBOauthViewModel: NSObject {

    // 把是否登录的逻辑放在oauthViewModel
    var isLogin: Bool {
        return userModel?.access_token == nil ? false : true
    }

    // 定义为单例, 方便外界调用, 同时返回的数据指向同一块内存区域
    static let sharedInstance: HBOauthViewModel = HBOauthViewModel()

    // 第一次赋值 -- 网络请求时
    // 第二次赋值 -- 读取解档方法
    var userModel: HBUserModel?

    // 直接把userModel的属性access_token放在viewModel中, 方便用户调用
    var access_token: String? {
        return userModel?.access_token
    }

    // 初始化方法里, 解档, 读取数据
    override init() {
        userModel = HBUserModel.readUserInfo()
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
//            printLog(JSON)
//            success()
            /*
            "access_token" = "2.00rKqTjCXublFD887f1561155P8HSB";
            "expires_in" = 157679999;
            "remind_in" = 157679999;
            uid = 2504312857;
            */

            // 问题: AnyObject? 不能放在字典里
            // 解决思路: 对 AnyObject? 进行转换
            guard let jsonDict = JSON as? [String : AnyObject] else {
                return
            }
            let model = HBUserModel(dict: jsonDict)
            printLog(model.access_token)

            // 调用方法
            self.loadUserInfo(model, infoSuccess: success, infoFailure: failure)


            }) { (error) -> Void in
                printLog(error)
                failure()
        }
    }

    /*
    access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
    uid	false	int64	需要查询的用户ID。
    screen_name	false	string	需要查询的用户昵称。
    */
    // MARK: - 通过token获取用户信息
    func loadUserInfo(model: HBUserModel, infoSuccess: ()->(), infoFailure: ()->()) {
        guard let access_token = model.access_token, uid = model.uid else {
            return
        }
        let params = ["access_token" : access_token, "uid" : uid]   // 为什么此处uid为非必须, 不传入则请求失败

        HBHTTPClient.request(.GET, URLString: "https://api.weibo.com/2/users/show.json", parameters: params, success: { (JSON) -> Void in
//            printLog(JSON)

            guard let jsonDict = JSON as? [String : AnyObject] else {
                return
            }
            let model = HBUserModel(dict: jsonDict)
            printLog("\(model.screen_name)\n\(model.profile_image_url)")

            //网络请求成功后, 给model赋值 (只走一次, 授权成功之后不会再走)
            self.userModel = model

            // 归档
            model.saveUserModel()

            // 深度调用完成
            infoSuccess()

            }) { (error) -> Void in
                printLog(error)
                infoFailure()
        }
    }
}
