//
//  ATResourceModel.swift
//  akashiToolkit
//
//  Created by LarrySue on 2018/1/8.
//  Copyright © 2018年 kcwikizh. All rights reserved.
//

import Foundation

class ATResourceModel: ATDictCreatable {

    // MARK: *** 属性 ***
    
    ///油
    var oil: Int = 0
    ///弹
    var ammunition: Int = 0
    ///钢
    var steel: Int = 0
    ///铝
    var aluminium: Int = 0
    
    required init?(dict: [AnyHashable : Any]) {
        if let oil = dict["oil"] as? Int {
            self.oil = oil
        }
        if let ammunition = dict["ammunition"] as? Int {
            self.ammunition = ammunition
        }
        if let steel = dict["steel"] as? Int {
            self.steel = steel
        }
        if let aluminium = dict["aluminium"] as? Int {
            self.aluminium = aluminium
        }
    }
    
    init(oil: Int = 0, ammunition: Int = 0, steel: Int = 0, aluminium: Int = 0) {
        self.oil = oil
        self.ammunition = ammunition
        self.steel = steel
        self.aluminium = aluminium
    }
}
