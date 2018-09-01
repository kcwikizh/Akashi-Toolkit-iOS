//
//  DataTool.swift
//  akashiToolkit
//
//  Created by LarrySue on 2018/1/7.
//  Copyright © 2018年 kcwikizh. All rights reserved.
//

import Foundation

struct DataTool {
    
}

// MARK: *** 初始化 ***

extension DataTool {
    
    ///数据初始化回调
    typealias DataInitCompletionHandler = (_ error: Error?) -> Void
    
    ///初始化海域数据 初始本地ATArea ATMap ATMapCell三组数据 并保存版本号
    static func initArea(_ completionHandler: @escaping DataInitCompletionHandler) {
        
        ///拉取数据
        NetworkTool.fetchAllAreaList { (areaFetchResult, error) in
            if let areaFetchResult = areaFetchResult {
                
                ///创建海域 海图 海图点列表
                var areaList: [AreaModel] = []
                var areaMapList: [AreaMapModel] = []
                var areaMapCellList: [AreaMapCellModel] = []
                
                ///遍历拉取结果 对象化 填入对应列表
                func hashmapToAreaMapCellModel(_ cell: [String : AnyObject]) {
                    if let cellModel = AreaMapCellModel(dict: cell) {
                        areaMapCellList.append(cellModel)
                    }
                }
                func hashmapToAreaMapModel(_ map: [String : AnyObject]) {
                    if let mapModel = AreaMapModel(dict: map) {
                        areaMapList.append(mapModel)
                    }
                    if let cellList = map["mapcell"] as? [[String : AnyObject]] {
                        let _ = cellList.map(hashmapToAreaMapCellModel)
                    }
                }
                func hashmapToAreaModel(_ area: [String : AnyObject]) {
                    if let areaModel = AreaModel(dict: area) {
                        areaList.append(areaModel)
                    }
                    if let mapList = area["mapinfo"] as? [[String : AnyObject]] {
                        let _ = mapList.map(hashmapToAreaMapModel)
                    }
                }
                let _ = areaFetchResult.map(hashmapToAreaModel)
                
                ///插入数据库
                DBTool.insert(areaList)
                DBTool.insert(areaMapList)
                DBTool.insert(areaMapCellList)
                
                ///执行回调
                completionHandler(nil)
            } else {
                completionHandler(error)
            }
        }
    }
}

// MARK: *** 官推 ***

extension DataTool {
    
    ///获取官推历史头像列表
    static func getAvatarList(_ completionHandler: @escaping ([URL], String?) -> Void) {
        NetworkTool.fetchAvatarList(completionHandler)
    }
}
