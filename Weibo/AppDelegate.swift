//
//  AppDelegate.swift
//  Weibo
//
//  Created by Beans on 16/6/25.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = rootVc()
        self.window?.makeKeyAndVisible()

        // 设置navBar 和 tabBar 外观
        setAppearance()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.wantToChangeRootVc(_:)), name: kNotificationWantToChangeRootVc, object: nil)

        return true
    }

    private func setAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
    }

    // 当没有登录的时候, 显示是访客视图(tabBarVc);
    // 当登录的时候, 显示的是欢迎界面 {欢迎界面完成之后, 是首页}
    private func rootVc() -> UIViewController {
        return HBOauthViewModel.sharedInstance.isLogin ? HBWelcomeViewController() : HBTabBarController()
    }

    // MARK: - 控制器切换控制
    // 授权成功之后跳转到欢迎界面; 欢迎界面再跳转的是首页
    @objc private func wantToChangeRootVc(noti: NSNotification) {
        let vc = noti.object as? UIViewController
        if vc is HBOauthViewController {
            window?.rootViewController = HBWelcomeViewController()
        } else {
            window?.rootViewController = HBTabBarController()
        }
    }

    // 移除通知
    deinit {    // (此处AppDelegate不走deinit, 但要养成习惯)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

