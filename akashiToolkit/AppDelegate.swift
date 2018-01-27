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
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        ///检查用户是否是首次进入APP
        if ATUserSettingTool.getIsFirstTimeUse() {
            firstUseGuideVc = ATFirstUseGuideViewController()
//        } else if ATUserSettingTool.isUpdated() {
//            newVersionGuideVc = ATNewVersionGuideViewController()
        }
    
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if firstUseGuideVc != nil {
            window.rootViewController = firstUseGuideVc!
        } else if newVersionGuideVc != nil {
            window.rootViewController = newVersionGuideVc!
        } else {
            window.rootViewController = ATNavigationController(rootViewController:ATHomeViewController())
        }
        window.makeKeyAndVisible()
        
        return true
    }
}

