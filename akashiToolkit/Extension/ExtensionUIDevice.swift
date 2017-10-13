//
//  ExtensionUIDevice.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/13.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

extension UIDevice {
    
    // MARK: *** 判断屏幕尺寸 ***
    
    ///5 5S SE 小尺寸屏幕
    class func isLittleSize() -> Bool {
        if UIScreen.height == 568 {
            return true
        } else {
            return false
        }
    }
    ///6 6S 7 8 普通尺寸
    class func isNormalSize() -> Bool {
        if UIScreen.height == 667 {
            return true
        } else {
            return false
        }
    }
    ///6P 6SP 7P 8P 大尺寸屏幕
    class func isLargeSize() -> Bool {
        if UIScreen.height == 736 {
            return true
        } else {
            return false
        }
    }
    ///X 操蛋屏幕
    class func isFuckedX() -> Bool {
        if UIScreen.height == 812 {
            return true
        } else {
            return false
        }
    }
}
