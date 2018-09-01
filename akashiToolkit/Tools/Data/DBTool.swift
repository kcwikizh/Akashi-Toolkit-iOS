//
//  DBTool.swift
//  akashiToolkit
//
//  Created by LarrySue on 2018/1/15.
//  Copyright © 2018年 kcwikizh. All rights reserved.
//

import Foundation
import WCDBSwift

struct DBTool {
    
    ///数据库所在目录路径
    private static let databaseDictPath = Constant.Path.document + "/database"
    ///数据库路径
    private static let databasePath = databaseDictPath + "/ATDatabase.db"
    
    ///数据库单例
    private static let database = Database(withPath: databasePath)
    
    ///表名
    private struct TableName {
        static let area = "area"
        static let areaMap = "areaMap"
        static let areaMapCell = "areaMapCell"
    }
}

// MARK: *** 初始化 ***

extension DBTool {
    
    ///初始化数据库并建表
    static func initDatabase() {
        ///针对初始化数据失败过的情况 清空数据库目录
        let fm = FileManager.default
        
        if fm.fileExists(atPath: databaseDictPath) {
            do {
                try fm.removeItem(at: URL(fileURLWithPath: databaseDictPath))
            } catch {
                print("larry sue : \(error)")
                print("larry sue : \(DbError.deleteDatabaseDictFailed)")
            }
        }
        
        ///创建舰娘表
        ///创建装备表
        ///创建海域表
        do {
            try database.create(table: TableName.area, of: AreaModel.self)
        } catch {
            print("larry sue : \(error)")
            print("larry sue : \(DbError.createAreaTableFailed)")
        }
        ///创建海图表
        do {
            try database.create(table: TableName.areaMap, of: AreaMapModel.self)
        } catch {
            print("larry sue : \(error)")
            print("larry sue : \(DbError.createAreaMapTableFailed)")
        }
        ///创建海图点表
        do {
            try database.create(table: TableName.areaMapCell, of: AreaMapCellModel.self)
        } catch {
            print("larry sue : \(error)")
            print("larry sue : \(DbError.createAreaMapCellTableFailed)")
        }
    }
    ///插入海域数据
    static func insert(_ areaList: [AreaModel]) {
        if areaList.count == 0 { return }
        do {
            try database.insert(objects: areaList, intoTable: TableName.area)
        } catch {
            print("larry sue : \(error)")
            print("larry sue : \(DbError.insertAreaListFailed)")
        }
    }
    ///插入海图数据
    static func insert(_ areaMapList: [AreaMapModel]) {
        if areaMapList.count == 0 { return }
        do {
            try database.insert(objects: areaMapList, intoTable: TableName.areaMap)
        } catch {
            print("larry sue : \(error)")
            print("larry sue : \(DbError.insertAreaMapListFailed)")
        }
    }
    ///插入海图点数据
    static func insert(_ areaMapCellList: [AreaMapCellModel]) {
        if areaMapCellList.count == 0 { return }
        do {
            try database.insert(objects: areaMapCellList, intoTable: TableName.areaMapCell)
        } catch {
            print("larry sue : \(error)")
            print("larry sue : \(DbError.insertAreaMapCellListFailed)")
        }
    }
}

// MARK: -

private struct DbError {
    
    private init() {}
}

// MARK: *** 初始化 ***

extension DbError {
    
    ///创建海域表错误
    fileprivate static let createAreaTableFailed = NSError(domain: Constant.Error.Domain.database, code: 37130, userInfo: [NSLocalizedDescriptionKey: "Create Area Table Failed"])
    ///创建海图表错误
    fileprivate static let createAreaMapTableFailed = NSError(domain: Constant.Error.Domain.database, code: 37131, userInfo: [NSLocalizedDescriptionKey: "Create Area Map Table Failed"])
    ///创建海图点表错误
    fileprivate static let createAreaMapCellTableFailed = NSError(domain: Constant.Error.Domain.database, code: 37132, userInfo: [NSLocalizedDescriptionKey: "Create Area Map Cell Table Failed"])
    
    ///插入海域数组错误
    fileprivate static let insertAreaListFailed = NSError(domain: Constant.Error.Domain.database, code: 37230, userInfo: [NSLocalizedDescriptionKey: "Insert Area List Failed"])
    ///插入海图数组错误
    fileprivate static let insertAreaMapListFailed = NSError(domain: Constant.Error.Domain.database, code: 37231, userInfo: [NSLocalizedDescriptionKey: "Insert Area Map List Failed"])
    ///插入海图点数组错误
    fileprivate static let insertAreaMapCellListFailed = NSError(domain: Constant.Error.Domain.database, code: 37232, userInfo: [NSLocalizedDescriptionKey: "Insert Area Map Cell List Failed"])
}

// MARK: *** 其他操作 ***

extension DbError {
    
    ///清理未初始化完成的数据库目录失败
    fileprivate static let deleteDatabaseDictFailed = NSError(domain: Constant.Error.Domain.database, code: 37801, userInfo: [NSLocalizedDescriptionKey: "Delete Database Dictionary Failed"])
}
