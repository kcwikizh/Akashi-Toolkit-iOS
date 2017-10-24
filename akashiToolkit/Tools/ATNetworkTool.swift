//
//  ATNetworkTool.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/17.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit
import Alamofire

class ATAPIClient {
    
    private typealias ATAPIClientCompletionHandler = (_ items: AnyObject?, _ error: Error?) -> Void
    
    /// MARK: *** 请求 ***
    
    ///GET
    private class func getItems(for API: String, with parameter: [String : AnyObject]? = nil, _ handler: @escaping ATAPIClientCompletionHandler) {
        
        guard let url = URL(string: API) else {
            let outputError = ATNetworkError.invalidURL
            handler(nil, outputError)
            return
        }
        
        var outputItem: AnyObject? = nil
        var outputError: Error? = nil
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        request(url, method: .get, parameters: parameter).responseJSON { (response) in
            
            defer {
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(outputItem, outputError)
                })
            }
            
            outputError = response.error
            
            guard let data = response.data else { return }
            
            do {
                outputItem = try JSONSerialization.jsonObject(with: data) as AnyObject
                return
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
    class func getCurrentAvatar(_ completionHandler: @escaping (URL?, Error?) -> Void) {
        getItems(for: ATAPI.home.latestTwitterAvatar) { (result, error) in
            if let result = result as? [String : String] {
                completionHandler(URL(string: result["latest"]!), nil)
            } else {
                completionHandler(nil, error)
            }
        }
    }
    ///获取官推历史头像列表
    class func getAvatarList(_ completionHandler: @escaping ([URL?]?, Error?) -> Void) {
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
}

private struct ATAPI {
    
    private init() {}
    
    /// MARK: *** BASE ***
    
    private static let base = "https://t.kcwiki.moe/api"
    
    /// MARK: *** 主页 ***
    
    fileprivate struct home {
        ///官推
        static let twitter = "\(base)/flow/get"
        ///官推最新头像
        static let latestTwitterAvatar = "https://api.kcwiki.moe/avatar/latest"
        ///官推头像列表
        static let twitterAvatarList = "http://api.kcwiki.moe/avatars"
    }
}

private struct ATNetworkError {
    
    private init() {}
    
    /// MARK: *** 网络请求错误 ***
    
    fileprivate static let invalidURL = NSError(domain: "Invalid URL", code: 111, userInfo: nil)
    fileprivate static let invalidResponse = NSError(domain: "Invalid response", code: 112, userInfo: nil)
}
