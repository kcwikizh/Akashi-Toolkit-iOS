//
//  ExtensionString.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/24.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

extension String {
    func renderSize(font: UIFont) -> CGSize {
        let string = self as NSString
        return string.size(withAttributes: [.font: font])
    }
}
