//
//  ExtensionUIView.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/14.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

extension UIView {
    var width: CGFloat {
        get {
            return self.frame.width
        }
    }
    var height: CGFloat {
        get {
            return self.frame.height
        }
    }
    
//    func toImage() -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
//        
//        if let context = UIGraphicsGetCurrentContext() {
//            layer.render(in: context)
//            
//            let image = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            
//            return image
//        } else {
//            return nil
//        }
//    }
}
