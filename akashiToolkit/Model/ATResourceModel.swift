//
//  ATResourceModel.swift
//  akashiToolkit
//
//  Created by LarrySue on 2018/1/8.
//  Copyright © 2018年 kcwikizh. All rights reserved.
//

import Foundation
import WCDBSwift

class ATResourceModel: ColumnCodable {

    // MARK: *** 属性 ***
    
    ///油
    var oil: Int
    ///弹
    var ammunition: Int
    ///钢
    var steel: Int
    ///铝
    var aluminium: Int
    
    init(oil: Int = 0, ammunition: Int = 0, steel: Int = 0, aluminium: Int = 0) {
        self.oil = oil
        self.ammunition = ammunition
        self.steel = steel
        self.aluminium = aluminium
    }
    
    // MARK: *** WCDB.ColumnCodable ***
    
    static var columnType: ColumnType {
        get {
            return .text
        }
    }
    
    required convenience init?(with value: FundamentalValue) {
        if let data = value.stringValue.data(using: .utf8) {
            do {
                if let arr = try JSONSerialization.jsonObject(with: data) as? [Int], arr.count == 4 {
                    self.init(oil: arr[0], ammunition: arr[1], steel: arr[2], aluminium: arr[3])
                } else {
                    self.init()
                }
            } catch {
                self.init()
            }
        } else {
            self.init()
        }
    }
    
    func archivedValue() -> FundamentalValue {
        let arr = [oil, ammunition, steel, aluminium]
        
        do {
            if let str = try String(data: JSONSerialization.data(withJSONObject: arr), encoding: .utf8) {
                return FundamentalValue(str)
            } else {
                return FundamentalValue()
            }
        } catch {
            return FundamentalValue()
        }
    }
}
