//
//  ATUserSettingTool.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/11/27.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import Foundation

protocol UserDefaultsSettable {
    associatedtype defaultKeys: RawRepresentable
}

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

final class ATUserSettingTool {
    ///用户基础设置
    private struct Base: UserDefaultsSettable {
        enum defaultKeys: String {
            case twitterLanguage
        }
    }
    
    ///获取推特语言设置
    class func getTwitterLanguage() -> ATUserSetting.twitter.language {
        if let langValue = Base.integer(forKey: .twitterLanguage) {
            if let lang = ATUserSetting.twitter.language(rawValue: langValue) {
                return lang
            } else {
                return .zh
            }
        } else {
            Base.set(value: ATUserSetting.twitter.language.zh.rawValue, forKey: .twitterLanguage)
            return .zh
        }
    }
    ///保存推特语言设置
    class func setTwitterLanguage(_ lang: ATUserSetting.twitter.language) {
        Base.set(value: lang.rawValue, forKey: .twitterLanguage)
    }
}

private extension UserDefaultsSettable where defaultKeys.RawValue == String {
    static func set(value: Any?, forKey key: defaultKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    static func set(value: Int?, forKey key: defaultKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    static func value(forKey key: defaultKeys) -> Any? {
        return UserDefaults.standard.value(forKey: key.rawValue)
    }
    static func integer(forKey key: defaultKeys) -> Int? {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
}
