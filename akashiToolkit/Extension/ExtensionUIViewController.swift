//
//  ExtensionUIViewController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/21.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

extension UIViewController {
    ///获取当前显示的控制器
    static let current: UIViewController? = {
        var window = UIApplication.shared.keyWindow
        
        if window?.windowLevel != UIWindowLevelNormal {
            let windows = UIApplication.shared.windows
            for tmpWin in windows {
                if tmpWin.windowLevel == UIWindowLevelNormal {
                    window = tmpWin
                    break
                }
            }
        }
        
        let frontView = window?.subviews.first
        let nextResponder = frontView?.next
        
        if (nextResponder?.isKind(of: UIViewController.self))! {
            return nextResponder as? UIViewController
        } else {
            return window?.rootViewController
        }
    }()
    ///获取当前present出的控制器
    static let currentPresented: UIViewController? = {
        let appRootVC = UIApplication.shared.keyWindow?.rootViewController
        if let presentedViewController = appRootVC?.presentedViewController {
            return presentedViewController
        } else {
            return appRootVC
        }
    }()
}
