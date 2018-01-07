//
//  ATMapResourceModel.swift
//  akashiToolkit
//
//  Created by LarrySue on 2018/1/8.
//  Copyright © 2018年 kcwikizh. All rights reserved.
//

import UIKit

@objc public class ATMapResourceModel: NSObject {
    
    var oil: Int
    var ammunition: Int
    var steel: Int
    var aluminium: Int
    
    required public init(oil: Int, ammunition: Int, steel: Int, aluminium: Int) {
        self.oil = oil
        self.ammunition = ammunition
        self.steel = steel
        self.aluminium = aluminium
        
        super.init()
    }
}
