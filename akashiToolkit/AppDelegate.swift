//
//  AppDelegate.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/9.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    
    ///首次使用引导页
    var firstUseGuideVc: ATFirstUseGuideViewController?
    ///新版本引导页
    var newVersionGuideVc: ATNewVersionGuideViewController?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        ///检查用户是否是首次进入APP
        if UserSettingTool.getIsFirstTimeUse() {
            firstUseGuideVc = ATFirstUseGuideViewController()
//        } else if ATUserSettingTool.isUpdated() {
//            newVersionGuideVc = ATNewVersionGuideViewController()
        }
    
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if firstUseGuideVc != nil {
            window.rootViewController = firstUseGuideVc!
        } else if newVersionGuideVc != nil {
            window.rootViewController = newVersionGuideVc!
        } else {
            window.rootViewController = BaseNavigationController(rootViewController:HomeViewController())
        }
        window.makeKeyAndVisible()
        
        return true
    }
}

