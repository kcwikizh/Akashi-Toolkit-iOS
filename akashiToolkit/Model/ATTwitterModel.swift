//
//  ATTwitterModel.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/17.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import Foundation

class ATTwitterModel: ATDictCreatable {
    
    let jpContent: String
    let zhContent: String
    let dateStr: String
    let imageURLStr: String?
    
    required init?(dict: [AnyHashable : Any]) {
        guard let jpContent = dict["jp"] as? String else {
            return nil
        }
        guard let zhContent = dict["zh"] as? String else {
            return nil
        }
        guard let date = dict["date"] as? String else {
            return nil
        }
        
        self.jpContent = jpContent
        self.zhContent = zhContent
        self.dateStr = date
        self.imageURLStr = dict["img"] as? String
    }
}
