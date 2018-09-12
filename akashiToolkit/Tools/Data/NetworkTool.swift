//
//  NetworkTool.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/17.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import Moya
import RxMoya
import RxSwift
import SwiftyJSON

struct NetworkTool {
    private static let disposeBag = DisposeBag()
}

// MARK: *** 首页 ***

extension NetworkTool {
    
    ///获取官推
    static func fetchTwitterList(count: Int = 15, until: Int = 0, completionHandler: @escaping (_ items: AnyObject?, _ error: Error?) -> Void) {
        let prov = MoyaProvider<TwitterAPI>()
        prov.request(.twitterList(count: count, until: until)) { (result) in
            switch result {
            case let .success(response):
                print("larry sue twitter : \(response)")
            case let .failure(error):
                print("larry sue twitter : \(error)")
            }
        }
    }
    ///获取当前官推头像
    static func fetchCurrentAvatar(_ completionHandler: @escaping (URL?, String?) -> Void) {
        
        let prov = MoyaProvider<TwitterAPI>()
        
        prov.rx.request(.lastAvatar)
            .filterSuccessfulStatusCodes()
            .debug()
            .subscribe(onSuccess: { (response) in
                do {
                    let json = try JSON(data: response.data)
                    let avatarURL = URL(string: json["latest"].string!)
                    
                    completionHandler(avatarURL, nil)
                } catch {
                    completionHandler(nil, "NetworkTool.TwitterAPI.lastAvatar WRONG JSON : \(error)")
                }
            }) { (error) in
                completionHandler(nil, "NetworkTool.TwitterAPI.lastAvatar ERROR : \(error)")
            }
        .disposed(by: disposeBag)
    }
    ///获取官推历史头像列表
    static func fetchAvatarList(_ completionHandler: @escaping ([URL], String?) -> Void) {
        
        let prov = MoyaProvider<TwitterAPI>()
        
        prov.rx.request(.avatarList)
            .filterSuccessfulStatusCodes()
            .debug()
            .subscribe(onSuccess: { (response) in
                do {
                    let json = try JSON(data: response.data)
                    
                    let baseURL = json["base"].string
                    let archives = json["archives"].array
                    
                    let imgURLList = (archives?.map({ archive in
                        return URL(string: baseURL! + archive.string!)!
                    }))!
                    completionHandler(imgURLList.reversed(), nil)
                } catch {
                    completionHandler([], "NetworkTool.TwitterAPI.avatarList WRONG JSON: \(error)")
                }
            }, onError: { (error) in
                completionHandler([], "NetworkTool.TwitterAPI.avatarList ERROR : \(error)")
            })
        .disposed(by: disposeBag)
    }
}

// MARK: *** 初始化 ***

extension NetworkTool {
    
    ///获取海域全列表
    static func fetchAllAreaList(_ completionHandler: @escaping ([[String : AnyObject]]?, Error?) -> Void) {
    }
}

// MARK: - API

enum TwitterAPI {
    ///最新头像
    case lastAvatar
    ///头像列表 倒序
    case avatarList
    ///count 拉取条数 until 从哪个ID开始 例如传count=10,until=100 则倒序返回10条ID小于100的推
    case twitterList(count:Int, until: Int)
}

extension TwitterAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://api.kcwiki.moe")!
    }
    
    var path: String {
        switch self {
        case .lastAvatar:
            return "/avatar/latest"
        case .avatarList:
            return "/avatars"
        case let .twitterList(count, _):
            return "/tweet/\(count)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameter: [String: Any?] {
        switch self {
        case .lastAvatar, .avatarList:
            return [:]
        case let .twitterList(_, until):
            if until == 0 {
                return [:]
            } else {
                return ["until": until]
            }
        }
    }
    
    var sampleData: Data {
        
        var responseStr = "{}"
        
        switch self {
        case .lastAvatar:
            responseStr = "{\"latest\":\"http://static.kcwiki.moe/Avatar/KanColleStaffAvatar201808302200.png\"}"
        case .avatarList:
            responseStr = "{\"baseaaa\":\"http://static.kcwiki.moe/Avatar/\",\"archives\":[\"KanColleStaffAvatar201510022258.png\",\"KanColleStaffAvatar201510030942.png\"]}"
        default:
            responseStr = "{\"test\": \"TwitterAPI.sampleData\"}"
        }
        
        return responseStr.data(using: .utf8)!
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
