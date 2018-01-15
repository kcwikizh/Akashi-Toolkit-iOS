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
    
    ///获取海域全列表 初始本地ATArea ATMap ATMapCell三组数据 并保存版本号
    class func getAllAreaList(_ completionHandler: @escaping (AnyObject?, Error?) -> Void) {
        ATNetworkTool.fetchAllAreaList { (resObj, error) in
            print("larry sue : \(String(describing: resObj))")
        }
    }
}
