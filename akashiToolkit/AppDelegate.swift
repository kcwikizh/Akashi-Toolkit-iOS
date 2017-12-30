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
    var guideVc: ATViewController?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        ///检查用户是否是首次进入APP
        if ATUserSettingTool.getIsFirstUse() {
            
        }
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let homeVc = ATHomeViewController()
        window.rootViewController = ATNavigationController(rootViewController:homeVc)
        window.makeKeyAndVisible()
        
        if guideVc != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                homeVc.present(self.guideVc!, animated: true)
            })
        }
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        return true
    }
}

