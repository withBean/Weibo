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
        let client_id = AppKey
        let redirect_uri = AppRedirectURI

        let url = NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(client_id)&redirect_uri=\(redirect_uri)")
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
}