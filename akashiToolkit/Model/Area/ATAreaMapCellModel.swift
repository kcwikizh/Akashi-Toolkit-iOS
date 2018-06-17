//
//  ATAreaMapCellModel.swift
//  akashiToolkit
//
//  Created by LarrySue on 2018/1/19.
//  Copyright © 2018年 kcwikizh. All rights reserved.
//

import UIKit
import WCDBSwift

///海域类型
enum ATAreaMapCellType: Int32, ColumnCodable {
    
    
    ///出发点 初期位置
    case start = 0
    ///空气点 蓝点 存在せず
    case noBattle = 1
    ///资源点 绿点 資源獲得
    case resourceAccess = 2
    ///漩涡点 粉点 渦潮
    case vortex = 3
    ///普通战斗点 通常戦闘, 気のせいだった
    case normal = 4
    ///BOSS点 ボス戦闘
    case boss = 5
    ///登陆点 揚陸地点
    case beachhead = 6
    ///航空戦 1-6
    case airBattle = 7
    ///资源运送点 1-6 最终资源点 船団護衛成功
    case resourceTransport = 8
    ///空中侦察点 6-3 GH点 航空偵察
    case aerialReconnaissance = 9
    ///空袭点 6-4 DFGI点 長距離空襲戦
    case airRaid = 10
    
    // MARK: *** WCDB.ColumnCodable ***
    
    static var columnType: ColumnType {
        get {
            return .integer32
        }
    }
    
    init?(with value: FundamentalValue) {
        self.init(rawValue: value.int32Value)
    }
    
    func archivedValue() -> FundamentalValue {
        return FundamentalValue(self.rawValue)
    }
}

// MARK: -

class ATAreaMapCellModel: TableCodable, ATDictCreatable {
    
    // MARK: *** 属性 ***
    
    ///ID
    var identifier: Int?
    ///服务端ID
    var serverId: Int = 0
    ///海域服务端ID
    var areaServerId: Int = 0
    ///海图服务端ID
    var mapServerId: Int = 0
    ///海域内海图编号
    var mapNumber: Int = 0
    ///海图内编号
    var number: Int = 0
    ///类型
    var type: ATAreaMapCellType = .normal
    
    // MARK: *** 构造 ***
    
    convenience required init?(dict: [AnyHashable : AnyObject]) {
        self.init()
        if let serverId = dict["id"] as? Int {
            self.serverId = serverId
        }
        if let areaServerId = dict["maparea_id"] as? Int {
            self.areaServerId = areaServerId
        }
        if let mapServerId = dict["map_no"] as? Int {
            self.mapServerId = mapServerId
        }
        if let mapNumber = dict["mapinfo_no"] as? Int {
            self.mapNumber = mapNumber
        }
        if let number = dict["no"] as? Int {
            self.number = number
        }
        if let typeCode = dict["color_no"] as? Int32 {
            if let type = ATAreaMapCellType(rawValue: typeCode) {
                self.type = type
            } else {
                self.type = .normal
            }
        }
    }
    
    // MARK: *** WCBD ***
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = ATAreaMapCellModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        ///ID
        case identifier = "id"
        ///服务端ID
        case serverId
        ///海域服务端ID
        case areaServerId
        ///海图服务端ID
        case mapServerId
        ///海域内海图编号
        case mapNumber
        ///海图内编号
        case number
        ///类型
        case type
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                identifier: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true)
            ]
        }
    }
    
    var lastInsertedRowID: Int64 = 0
}
