//
//  HBOauthViewController.swift
//  Weibo
//
//  Created by Beans on 16/7/4.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

class HBOauthViewController: UIViewController, UIWebViewDelegate {

    let webView: UIWebView = UIWebView()

    override func loadView() {
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupNav()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // 加载授权页面
    private func setupWebView() {
        let url = NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(AppKey)&redirect_uri=\(AppRedirectURI)")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        webView.delegate = self
    }

    private func setupNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .Plain, target: self, action: "backItemClick")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: .Plain, target: self, action: "autoFillItemClick")
    }

    @objc private func backItemClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @objc private func autoFillItemClick() {
        // 执行JavaScript语言 (引号的两种转换方式: 1> 转义; 2> " -> ')
        let jsString = "document.getElementById('userId').value='\(userId)';document.getElementById('passwd').value='\(passwd)'"
        webView.stringByEvaluatingJavaScriptFromString(jsString)
    }

    // MARK: - UIWebViewDelegate代理方法获取 code
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        printLog(request.URL)
        // Optional(https://github.com/withBean?code=d75acf438398ae83048450ddbc12ad26)

        if let urlString = request.URL?.absoluteString {
            if urlString.hasPrefix(AppRedirectURI) {
                printLog(urlString)
                // https://github.com/withBean?code=bb7eb11ef93bb5f5ba8ed25eb1ef4d83

                // 获取code的两种方法: ①'='截取, ②query
                /* For example, in the URL http://www.example.com/index.php?key1=value1&key2=value2, the query string is key1=value1&key2=value2. */
                if let queryString = request.URL?.query {
                    let startIndex = "code=".endIndex
                    let code = queryString.substringFromIndex(startIndex)
                    printLog(code)
                    // cc773071fb5225fb71604f48dbbf7084

                    // 通过code获取token
                    let webSuccess = {
                        printLog("请求成功")
                        self.backItemClick()    // dismiss
                    }
                    let webFailure = {
                        printLog("请求失败")
                    }
                    HBOauthViewModel.sharedInstance.loadToken(code, success: webSuccess, failure: webFailure)
                    return false                // 不显示回调页面, 跳转到欢迎页面或其它
                }
            }
        }

        return true
    }
}
