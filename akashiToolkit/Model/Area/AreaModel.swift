//
//  AreaModel.swift
//  akashiToolkit
//
//  Created by LarrySue on 2018/1/15.
//  Copyright © 2018年 kcwikizh. All rights reserved.
//

import Foundation
import WCDBSwift

///海域类型
enum AreaType: Int32, ColumnCodable {
    
    ///普通海域
    case normal = 0
    ///活动海域
    case event  = 1
    
    // MARK: *** WCDB.ColumnCodable ***
    
    static var columnType: ColumnType {
        return .integer32
    }
    
    init?(with value: FundamentalValue) {
        self.init(rawValue: value.int32Value)
    }
    
    func archivedValue() -> FundamentalValue {
        return FundamentalValue(self.rawValue)
    }
}

// MARK: -

struct AreaModel: TableCodable, DictCreatable {
    
    // MARK: *** 属性 ***
    
    ///ID
    var identifier: Int?
    ///服务端ID
    var serverId: Int = 0
    ///海域类型
    var type: AreaType = .event
    ///海域名称 (日文
    var jpName: String = ""
    
    // MARK: ***
    init?(dict: [AnyHashable : AnyObject]) {
        
        if let serverId = dict["id"] as? Int {
            self.serverId = serverId
        }
        if let type = dict["type"] as? Int32 {
            if let type = AreaType(rawValue: type) {
                self.type = type
            } else {
                self.type = .event
            }
        }
        if let jpName = dict["name"] as? String {
            self.jpName = jpName
        }
    }
    
    // MARK: *** WCBD ***
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = AreaModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        ///ID
        case identifier = "id"
        ///服务端ID
        case serverId
        ///海域类型
        case type
        ///海域名称 (日文
        case jpName
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                identifier: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true)
            ]
        }
    }
    
    var lastInsertedRowID: Int64 = 0
}
