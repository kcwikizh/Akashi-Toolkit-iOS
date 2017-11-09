//
//  ATUserSettingModel.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/11/9.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

struct ATUserSetting {
    struct twitter {
        enum language: Int {
            
            case zh = 0
            case jp = 1
            case both = 2
            
            static var list = [language.zh, language.jp, language.both]
            
            func toString() -> String {
                switch self {
                case .zh:
                    return "中文"
                case .jp:
                    return "日文"
                case .both:
                    return "中文及日文"
                }
            }
        }
    }
}

struct ATUserSettingModel {
    
    private init() {}
    
    static let `default` = ATUserSettingModel()
    static let shared = {
        return `default`
    }()
    
    var twitterLanguage: ATUserSetting.twitter.language = .zh
}
