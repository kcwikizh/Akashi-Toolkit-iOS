//
//  ATDataTool.swift
//  akashiToolkit
//
//  Created by LarrySue on 2018/1/7.
//  Copyright © 2018年 kcwikizh. All rights reserved.
//

import Foundation

final class ATDataTool {
    
    // MARK: *** 官推 ***
    
    ///获取官推历史头像列表
    class func getAvatarList(_ completionHandler: @escaping ([URL?]?, Error?) -> Void) {
        ATNetworkTool.fetchAvatarList(completionHandler)
    }
    
    // MARK: *** 初始化 ***
    
    ///数据初始化回调
    typealias ATDataInitCompletionHandler = (_ error: Error?) -> Void
    
    ///初始化海域数据 初始本地ATArea ATMap ATMapCell三组数据 并保存版本号
    class func initArea(_ completionHandler: @escaping ATDataInitCompletionHandler) {
        
        ///拉取数据
        ATNetworkTool.fetchAllAreaList { (areaFetchResult, error) in
            if let areaFetchResult = areaFetchResult {
                
                ///创建海域 海图 海图点列表
                var areaList: [ATAreaModel] = []
                var areaMapList: [ATAreaMapModel] = []
                
                func hashmapToAreaMapModel(_ map: [String : AnyObject]) {
                    if let mapModel = ATAreaMapModel(dict: map) {
                        areaMapList.append(mapModel)
                    }
                }
                func hashmapToAreaModel(_ area: [String : AnyObject]) {
                    if let areaModel = ATAreaModel(dict: area) {
                        areaList.append(areaModel)
                    }
                    if let mapList = area["mapinfo"] as? [[String : AnyObject]] {
                        let _ = mapList.map(hashmapToAreaMapModel)
                    }
                }
                
                ///遍历拉取结果 对象化 填入对应列表
                let _ = areaFetchResult.map(hashmapToAreaModel)
                
                ///插入数据库
                ATDBTool.insert(areaList)
                ATDBTool.insert(areaMapList)
                
                ///执行回调
                completionHandler(nil)
            } else {
                completionHandler(error)
            }
        }
    }
}
