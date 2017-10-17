//
//  ATTwitterModel.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/17.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

struct ATTwitterModel: ATDictCreatable {
    let id: Int
    let jpContent: String
    let zhContent: String
    let date: Date
    
    init?(dict: [AnyHashable : Any]) {
        guard let id = dict["id"] as? Int else { return nil }
        guard let jpContent = dict["jp"] as? String else { return nil }
        guard let zhContent = dict["zh"] as? String else { return nil }
        guard let date = dict["date"] as? Date else { return nil }
        
        self.id = id
        self.jpContent = jpContent
        self.zhContent = zhContent
        self.date = date
    }
}
