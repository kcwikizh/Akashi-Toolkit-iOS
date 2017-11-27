//
//  Constant.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/13.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    
    // MARK: *** 官方资料 ***
    
    struct official {
        ///官博
        static let weibo = URL(string: "https://weibo.com/kcwikizh")!
        ///微信号
        static let weixin = ""
        ///官方网址
        static let website = URL(string: "https://zh.kcwiki.org")!
        ///开发者邮箱
        static let developerEmail = "larry.dancingfire@gmail.com"
        ///数据反馈网址
        static let dataFeedback = URL(string: "https://task.kcwiki.org/home/menu/view/17/")!
    }
    
    /// MARK: *** UI ***
    
    struct ui {
        
        /// MARK: *** 尺寸 ***
        
        struct size {
            ///状态栏高度
            static let statusBarHeight: CGFloat = {
                if UIDevice.isFuckedX {
                    return 44.0
                } else {
                    return 20.0
                }
            }()
            ///导航栏标题高度
            static let navTitleBarHeight: CGFloat = 44.0
            ///导航栏大标题高度
            static let navLargeTitleBarHeight: CGFloat = 52.0
            ///状态栏+导航栏高度
            static let topHeight = statusBarHeight + navTitleBarHeight
            
            ///底部安全距离
            static let bottomSafePadding: CGFloat = {
                if UIDevice.isFuckedX {
                    return 34.0
                } else {
                    return 0.0
                }
            }()
            ///TabBar高度
            static let tabBarHeight: CGFloat = 49.0
            ///底部总高度
            static let bottomHeight = bottomSafePadding + tabBarHeight
            
            ///导航栏按钮距离屏幕侧边的距离
            static let navItemHorizontalPadding = 12.0
        }
        
        /// MARK: *** 色彩 ***
        
        struct color {
            ///导航栏主色
            static let theme = UIColor(234.0, 0.0, 100.0)
            ///浅背景色
            static let lightBackground = UIColor(233.0, 233.0, 233.0)
            ///深背景色
            static let darkBackground = UIColor(120.0, 120.0, 120.0)
            ///深前景色
            static let darkForeground = UIColor(50.0, 50.0, 50.0)
            ///浅前景色
            static let lightForeground = UIColor.white
            ///阴影色
            static let shadow = UIColor(white: 0.3, alpha: 0.5)
            ///主要文案
            static let majorText = UIColor(50.0, 50.0, 50.0)
            ///次要文案
            static let minorText = UIColor(102.0, 102.0, 102.0)
            ///辅助文案
            static let auxiliaryText = UIColor(136.0, 136.0, 136.0)
        }
    }
    
    /// MARK: *** AppDelegate ***
    
    static let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    /// MARK: *** Window ***
    
    static let window: UIWindow = appDelegate.window!
}
