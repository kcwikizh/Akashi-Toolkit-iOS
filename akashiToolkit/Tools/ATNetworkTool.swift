//
//  ATNetworkTool.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/17.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

struct ATAPIClient<DataType: ATDictCreatable> {
    
    typealias ATAPIClientCompletionHandler = (_ items: [DataType]?, _ error: Error?) -> Void
    
    /// MARK: *** 请求 ***
    
    ///简易API请求
    private func fetchItems(forURL url: URL, inDictionaryForKey key: String?, _ completionHandler: @escaping ATAPIClientCompletionHandler) {
        
        var outputItems: [DataType]? = nil
        var outputError: Error? = nil
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            defer {
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    completionHandler(outputItems, outputError)
                })
            }
            
            outputError = error
            
            guard let data = data else { return }
            
            do {
                var items: [[String: AnyObject]] = []
                
                if let key = key {
                    guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else  {
                        outputError = ATNetworkError.invalidResponse
                        return
                    }
                    guard let array = dict[key] as? [[String: AnyObject]] else {
                        outputError = ATNetworkError.invalidResponse
                        return
                    }
                    items = array
                } else {
                    guard let array = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: AnyObject]] else {
                        outputError = ATNetworkError.invalidResponse
                        return
                    }
                    items = array
                }
                
                var tempItems = [DataType]()
                
                for dict in items {
                    if let item = DataType(dict: dict as [AnyHashable: AnyObject]) {
                        tempItems.append(item)
                    }
                }
                
                outputItems = tempItems
                return
                
            } catch {
                outputError = error
            }
        }.resume()
    }
    
    /// MARK: *** 首页 ***
    
    ///获取官推
    func fetchTwitterList(count: Int, completionHandler: @escaping ATAPIClientCompletionHandler) {
        guard let url = ATAPI.home.twitter(count) else {
            let outputError = ATNetworkError.invalidParameter
            completionHandler(nil, outputError)
            return
        }
        fetchItems(forURL: url, inDictionaryForKey: nil, completionHandler)
    }
}

private struct ATAPI {
    
    private init() {}
    
    /// MARK: *** BASE ***
    
    private static let base = "http://api.kcwiki.moe"
    
    /// MARK: *** 主页 ***
    
    struct home {
        ///官推
        static func twitter(_ count: Int) -> URL? {
            return URL(string: "\(base)/tweet/\(count)")
        }
        ///官推最新头像
        static let latestTwitterAvatar = URL(string: "\(base)/avatar/latest")
    }
}

private struct ATNetworkError {
    
    private init() {}
    
    /// MARK: *** 网络请求错误 ***
    
    static let invalidParameter = NSError(domain: "Invalid parameter", code: 111, userInfo: nil)
    static let invalidResponse = NSError(domain: "Invalid response", code: 112, userInfo: nil)
}
