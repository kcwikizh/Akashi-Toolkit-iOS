//
//  ATAreaModel.swift
//  akashiToolkit
//
//  Created by LarrySue on 2018/1/15.
//  Copyright © 2018年 kcwikizh. All rights reserved.
//

import Foundation
import WCDBSwift

class ATAreaModel: TableCodable {
    
    var identifier: Int?
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = ATAreaModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        case identifier = "id"
    }
}
