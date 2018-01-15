//
//  ATNetworkTool.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/17.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit
import Alamofire

final class ATNetworkTool {
    
    private typealias ATAPIClientCompletionHandler = (_ items: AnyObject?, _ error: Error?) -> Void
    
    /// MARK: *** 请求 ***
    
    ///GET
    private class func getItems(for API: String, with parameter: [String : AnyObject]? = nil, _ handler: @escaping ATAPIClientCompletionHandler) {
        
        var outputItem: AnyObject? = nil
        var outputError: Error? = nil
        
        guard let url = URL(string: API) else {
            outputError = ATNetworkError.invalidURL
            handler(outputItem, outputError)
            return
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        request(url, method: .get, parameters: parameter).responseJSON { (response) in
            
            defer {
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(outputItem, outputError)
                })
            }
            
            outputError = response.error
            
            guard let data = response.data else {
                if outputError == nil {
                    outputError = ATNetworkError.invalidResponse
                }
                return
            }
            
            do {
                outputItem = try JSONSerialization.jsonObject(with: data) as AnyObject
            } catch {
                outputError = error
            }
        }
    }
    
    /// MARK: *** 首页 ***
    
    ///获取官推
    class func fetchTwitterList(count: Int, completionHandler: @escaping (_ items: AnyObject?, _ error: Error?) -> Void) {
        
    }
    ///获取当前官推头像
    class func fetchCurrentAvatar(_ completionHandler: @escaping (URL?, Error?) -> Void) {
        getItems(for: ATAPI.home.latestTwitterAvatar) { (result, error) in
            if let result = result as? [String : String] {
                completionHandler(URL(string: result["latest"]!), nil)
            } else {
                completionHandler(nil, error)
            }
        }
    }
    ///获取官推历史头像列表
    class func fetchAvatarList(_ completionHandler: @escaping ([URL?]?, Error?) -> Void) {
        getItems(for: ATAPI.home.twitterAvatarList) { (result, error) in
            if let result = result as? [String : AnyObject] {
                if let baseURL = result["base"] as? String, let archives = result["archives"] as? [String] {
                    completionHandler(archives.reversed().map({ itemURL in
                        return URL(string: baseURL + itemURL)
                    }), nil)
                }
            } else {
                completionHandler(nil, error)
            }
        }
    }
    
    // MARK: *** 初始化 ***
    
    ///获取海域全列表
    class func fetchAllAreaList(_ completionHandler: @escaping (AnyObject?, Error?) -> Void) {
        getItems(for: ATAPI.all.area, completionHandler)
    }
}

private struct ATAPI {
    
    private init() {}
    
    /// MARK: *** 主页 ***
    
    fileprivate struct home {
        ///官推
        static let twitter = "https://t.kcwiki.moe/api/flow/get"
        ///官推最新头像
        static let latestTwitterAvatar = "https://api.kcwiki.moe/avatar/latest"
        ///官推头像列表
        static let twitterAvatarList = "https://api.kcwiki.moe/avatars"
    }
    
    // MARK: *** 初始化 ***
    
    private static let allBase = "http://api.kcwiki.moe"
    
    ///获取全数据接口
    fileprivate struct all {
        ///全舰娘数据(含深海)
        static let ship = "\(allBase)/ships"
        ///全装备数据(含深海)
        static let equipment = "\(allBase)/slotitems"
        ///全海域数据
        static let area = "\(allBase)/maps"
        ///全任务数据
        static let mission = "\(allBase)/"
        ///全远征数据
        static let expedition = "\(allBase)/missions"
    }
}

private struct ATNetworkError {
    
    private init() {}
    
    /// MARK: *** 网络请求错误 ***
    
    fileprivate static let invalidURL = NSError(domain: Constant.error.domain.network, code: 39011, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
    fileprivate static let invalidResponse = NSError(domain: Constant.error.domain.network, code: 39012, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
}
