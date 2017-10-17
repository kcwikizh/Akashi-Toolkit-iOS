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
let UIStatusBarHeight: CGFloat = {
	if UIDevice.isFuckedX() {
        return 44.0
    } else {
        return 20.0
    }
}()
///导航栏标题高度
let UINavTitleBarHeight: CGFloat = 44.0
///导航栏大标题高度
let UINavLargeTitleBarHeight: CGFloat = 52.0
///状态栏+导航栏高度
let UITopHeight = UIStatusBarHeight + UINavTitleBarHeight

///底部安全距离
let UIBottomSafePadding: CGFloat = {
    if UIDevice.isFuckedX() {
        return 34.0
    } else {
        return 0.0
    }
}()
///TabBar高度
let UITabBarHeight: CGFloat = 49.0
///底部总高度
let UIBottomHeight = UIBottomSafePadding + UITabBarHeight
