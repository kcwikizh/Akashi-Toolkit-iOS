//
//  ATAreaMapModel.swift
//  akashiToolkit
//
//  Created by LarrySue on 2018/1/18.
//  Copyright © 2018年 kcwikizh. All rights reserved.
//

import UIKit
import WCDBSwift

class ATAreaMapModel: TableCodable, ATDictCreatable {
    
    // MARK: *** 属性 ***
    
    ///ID
    var identifier: Int?
    ///服务端ID
    var serverId: Int = 0
    ///海域服务端ID
    var areaServerId: Int = 0
    ///海域内编号
    var number: Int = 0
    ///难易度
    var level: Int = 0
    ///名称 (日文
    var name: String = ""
    ///作战名 (日文
    var battleName: String = ""
    ///描述信息 (日文
    var infoText: String = ""
    ///所获资源
    var gainResource: ATResourceModel = ATResourceModel()
    ///海域血量 若无则空
    var hp: Int?
    ///击破所需最少出击次数 若无则空
    var requiredDefeatCount: Int?
    
    // MARK: *** 构造 ***
    
    convenience required init?(dict: [AnyHashable : AnyObject]) {
        self.init()
        if let serverId = dict["id"] as? Int {
            self.serverId = serverId
        }
        if let areaServerId = dict["maparea_id"] as? Int {
            self.areaServerId = areaServerId
        }
        if let number = dict["no"] as? Int {
            self.number = number
        }
        if let level = dict["level"] as? Int {
            self.level = level
        }
        if let name = dict["name"] as? String {
            self.name = name
        }
        if let battleName = dict["ope_text"] as? String {
            self.battleName = battleName
        }
        if let infoText = dict["info_text"] as? String {
            self.infoText = infoText
        }
        if let gainResource = dict["item"] as? [Int] {
            if gainResource.count == 4 {
                self.gainResource = ATResourceModel(oil: gainResource[0], ammunition: gainResource[1], steel: gainResource[2], aluminium: gainResource[3])
            } else {
                self.gainResource = ATResourceModel()
            }
        }
        
        self.hp = dict["max_maphp"] as? Int
        self.requiredDefeatCount = dict["required_defeat_count"] as? Int
    }
    
    // MARK: *** WCBD ***
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = ATAreaMapModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        ///ID
        case identifier = "id"
        ///服务端ID
        case serverId
        ///海域服务端ID
        case areaServerId
        ///海域内编号
        case number
        ///难易度
        case level
        ///名称 (日文
        case name
        ///作战名 (日文
        case battleName
        ///描述信息 (日文
        case infoText
        ///所获资源
        case gainResource
        ///海域血量 若无则空
        case hp
        ///击破所需最少出击次数 若无则空
        case requiredDefeatCount
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                identifier: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true)
            ]
        }
    }
    
    var lastInsertedRowID: Int64 = 0
}
