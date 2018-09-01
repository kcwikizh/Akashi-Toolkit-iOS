//
//  UIFont+Additions.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/24.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

extension UIFont {
    ///动态字体 默认34号
    class var largeTitle: UIFont {
        if #available(iOS 11.0, *) {
            return preferredFont(forTextStyle: .largeTitle)
        } else {
            return UIFont.systemFont(ofSize: 34.0)
        }
    }
    ///动态字体 默认28号
    class var title1: UIFont {
        return preferredFont(forTextStyle: .title1)
    }
    ///动态字体 默认22号
    class var title2: UIFont {
        return preferredFont(forTextStyle: .title2)
    }
    ///动态字体 默认20号
    class var title3: UIFont {
        return preferredFont(forTextStyle: .title3)
    }
    ///动态字体 默认17号 Semi-Bold
    class var headline: UIFont {
        return preferredFont(forTextStyle: .headline)
    }
    ///动态字体 默认17号
    class var body: UIFont {
        return preferredFont(forTextStyle: .body)
    }
    ///动态字体 默认16号
    class var callout: UIFont {
        return preferredFont(forTextStyle: .callout)
    }
    ///动态字体 默认15号
    class var subheadline: UIFont {
        return preferredFont(forTextStyle: .subheadline)
    }
    ///动态字体 默认13号
    class var footnote: UIFont {
        return preferredFont(forTextStyle: .footnote)
    }
    ///动态字体 默认12号
    class var caption1: UIFont {
        return preferredFont(forTextStyle: .caption1)
    }
    ///动态字体 默认11号
    class var caption2: UIFont {
        return preferredFont(forTextStyle: .caption2)
    }
}
