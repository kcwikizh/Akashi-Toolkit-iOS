//
//  ExtensionUIImage.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/16.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

extension UIImage {
    ///重设图片尺寸
    func resizeImage(to size:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale);
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        
        return reSizeImage;
    }
    
    ///等比率缩放
    func scaleImage(to scale:CGFloat) -> UIImage {
        let reSize = CGSize(width: size.width * scale, height: size.height * scale)
        return resizeImage(to: reSize)
    }
}
