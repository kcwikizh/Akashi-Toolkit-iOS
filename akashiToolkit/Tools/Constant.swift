//
//  Constant.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/13.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import Foundation
import UIKit

///状态栏高度
let ATUIStatusBarHeight: CGFloat = {
	if UIDevice.isFuckedX() {
        return 44.0
    } else {
        return 20.0
    }
}()
///导航栏标题高度
let ATUINavTitleBarHeight: CGFloat = 44.0
///导航栏大标题高度
let ATUINavLargeTitleBarHeight: CGFloat = 52.0
///状态栏+导航栏高度
let ATUITopHeight = ATUIStatusBarHeight + ATUINavTitleBarHeight

///底部安全距离
let ATUIBottomSafePadding: CGFloat = {
    if UIDevice.isFuckedX() {
        return 34.0
    } else {
        return 0.0
    }
}()
///TabBar高度
let ATUITabBarHeight: CGFloat = 49.0
///底部总高度
let ATUIBottomHeight = ATUIBottomSafePadding + ATUITabBarHeight

///导航栏主色
let ATUINavigationBarColor = UIColor(234.0, 0.0, 100.0)
///浅色页面背景色
let ATUILightPageBackgroundColor = UIColor(233.0, 233.0, 233.0)
///深色页面背景色
let ATUIDarkPageBackgroundColor = UIColor(100.0, 100.0, 100.0)
