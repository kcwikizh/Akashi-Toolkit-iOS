//
//  UIColor+Additions.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/13.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    ///随机色
    class var random: UIColor {
        let r = akashiToolkit.random(from: 0, to: 255.0, decimal: 1)
        let g = akashiToolkit.random(from: 0, to: 255.0, decimal: 1)
        let b = akashiToolkit.random(from: 0, to: 255.0, decimal: 1)
        
        return UIColor(CGFloat(r), CGFloat(g), CGFloat(b))
    }
}
