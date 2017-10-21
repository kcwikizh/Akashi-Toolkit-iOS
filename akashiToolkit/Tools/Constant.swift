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
    
    /// MARK: *** UI ***
    
    struct ui {
        
        /// MARK: *** 尺寸 ***
        
        struct size {
            ///状态栏高度
            static let statusBarHeight: CGFloat = {
                if UIDevice.isFuckedX() {
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
                if UIDevice.isFuckedX() {
                    return 34.0
                } else {
                    return 0.0
                }
            }()
            ///TabBar高度
            static let tabBarHeight: CGFloat = 49.0
            ///底部总高度
            static let bottomHeight = bottomSafePadding + tabBarHeight
        }
        
        /// MARK: *** 色彩 ***
        
        struct color {
            ///导航栏主色
            static let navigationBar = UIColor(234.0, 0.0, 100.0)
            ///浅色页面背景色
            static let lightPageBackground = UIColor(233.0, 233.0, 233.0)
            ///深色页面背景色
            static let darkPageBackground = UIColor(100.0, 100.0, 100.0)
        }
    }
    
    /// MARK: *** AppDelegate ***
    
    static let appDelegate: AppDelegate = {
        return UIApplication.shared.delegate as! AppDelegate
    }()
}
