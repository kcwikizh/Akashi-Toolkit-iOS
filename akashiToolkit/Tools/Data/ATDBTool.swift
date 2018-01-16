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
    
    ///数据库所在目录路径
    private static let databaseDictPath = Constant.path.document + "/database"
    ///数据库路径
    private static let databasePath = databaseDictPath + "/ATDatabase.db"
    
    ///数据库单例
    private static let database = Database(withPath: databasePath)
    
    ///表名
    struct tableName {
        static let area = "area"
    }
    
    // MARK: *** 初始化 ***
    
    ///初始化数据库并建表
    class func initDatabase() {
        ///针对初始化数据失败过的情况 清空目录
        let fm = FileManager.default
        
        if fm.fileExists(atPath: databaseDictPath) {
            do {
                try fm.removeItem(at: URL(fileURLWithPath: databaseDictPath))
            } catch {
                print("larry sue : \(error)")
                print("larry sue : \(ATDatabaseError.deleteDatabaseDictFailed)")
            }
        }
        
        ///创建舰娘表
        ///创建装备表
        ///创建海域表
        do {
            try database.create(table: tableName.area, of: ATAreaModel.self)
        } catch {
            print("larry sue : \(error)")
            print("larry sue : \(ATDatabaseError.createAreaTableFailed)")
        }
        ///创建地图表
        ///创建地图点表
    }
    ///插入海域数据
    class func insert(_ areaList: [ATAreaModel]) {
        do {
            print("larry sue 2")
            try database.insert(objects: areaList, intoTable: tableName.area)
            print("larry sue 3")
        } catch {
            print("larry sue : \(error)")
            print("larry sue : \(ATDatabaseError.insertAreaListFailed)")
        }
    }
}

///数据库操作错误
private struct ATDatabaseError {
    
    private init() {}
    
    // MARK: *** 初始化 ***
    
    ///创建海域表错误
    fileprivate static let createAreaTableFailed = NSError(domain: Constant.error.domain.database, code: 37130, userInfo: [NSLocalizedDescriptionKey: "Create Area Table Failed"])
    ///创建地图表错误
    fileprivate static let createAreaMapTableFailed = NSError(domain: Constant.error.domain.database, code: 37131, userInfo: [NSLocalizedDescriptionKey: "Create Area Map Table Failed"])
    ///创建地图点表错误
    fileprivate static let createAreaMapCellTableFailed = NSError(domain: Constant.error.domain.database, code: 37132, userInfo: [NSLocalizedDescriptionKey: "Create Area Map Cell Table Failed"])
    
    ///插入海域数据数组错误
    fileprivate static let insertAreaListFailed = NSError(domain: Constant.error.domain.database, code: 37230, userInfo: [NSLocalizedDescriptionKey: "Insert Area List Failed"])
    
    // MARK: *** 其他操作 ***
    
    ///清理未初始化完成的数据库目录失败
    fileprivate static let deleteDatabaseDictFailed = NSError(domain: Constant.error.domain.database, code: 37801, userInfo: [NSLocalizedDescriptionKey: "Delete Database Dictionary Failed"])
}
