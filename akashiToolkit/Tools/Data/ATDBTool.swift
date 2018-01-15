//
//  ATDBTool.swift
//  akashiToolkit
//
//  Created by LarrySue on 2018/1/15.
//  Copyright © 2018年 kcwikizh. All rights reserved.
//

import Foundation
import WCDBSwift

final class ATDBTool {
    
    ///数据库路径
    private static let databasePath = Constant.path.document + "ATDatabase.db"
    
    class func initDatabase() {
        let database = Database(withPath: databasePath)
        
        ///创建舰娘表
        ///创建装备表
        ///创建海域表
        do {
            try database.create(table: "area", of: ATAreaModel.self)
        } catch {
            print("larry sue : \(error)")
            print("larry sue : \(ATDatabaseError.createAreaTableFailed)")
        }
        ///创建地图表
        ///创建地图点表
    }
}

///数据库操作错误
private struct ATDatabaseError {
    
    private init() {}
    
    ///创建海域表错误
    fileprivate static let createAreaTableFailed = NSError(domain: Constant.error.domain.database, code: 37030, userInfo: [NSLocalizedDescriptionKey: "Create Area Table Failed"])
    ///创建地图表错误
    fileprivate static let createAreaMapTableFailed = NSError(domain: Constant.error.domain.database, code: 37031, userInfo: [NSLocalizedDescriptionKey: "Create Area Map Table Failed"])
    ///创建地图点表错误
    fileprivate static let createAreaMapCellTableFailed = NSError(domain: Constant.error.domain.database, code: 37032, userInfo: [NSLocalizedDescriptionKey: "Create Area Map Cell Table Failed"])
}
