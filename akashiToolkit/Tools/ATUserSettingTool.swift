//
//  ATUserSettingTool.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/11/27.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import Foundation

private protocol UserDefaultsSettable {
    associatedtype defaultKeys: RawRepresentable
}

extension UserDefaultsSettable where defaultKeys.RawValue == String {
    static func set(_ value: Any?, forKey key: defaultKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    static func set(_ value: Int, forKey key: defaultKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    static func set(_ value: String?, forKey key: defaultKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    static func set(_ value: Bool, forKey key: defaultKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    static func value(forKey key: defaultKeys) -> Any? {
        return UserDefaults.standard.value(forKey: key.rawValue)
    }
    static func integer(forKey key: defaultKeys) -> Int {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    static func string(forKey key: defaultKeys) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    static func bool(forKey key: defaultKeys) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
}

// MARK: -

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

// MARK: -

final class ATUserSettingTool {
    
}

// MARK: *** 用户基础设置 ***

extension ATUserSettingTool {
    ///用户基础设置
    private struct Base: UserDefaultsSettable {
        enum defaultKeys: String {
            ///推特语言 枚举 ATUserSetting.twitter.language
            case twitterLanguage
        }
    }
    
    ///获取推特语言设置
    class func getTwitterLanguage() -> ATUserSetting.twitter.language {
        let langValue = Base.integer(forKey: .twitterLanguage)
        if let lang = ATUserSetting.twitter.language(rawValue: langValue) {
            return lang
        } else {
            return .zh
        }
    }
    ///保存推特语言设置
    class func setTwitterLanguage(_ lang: ATUserSetting.twitter.language) {
        Base.set(lang.rawValue, forKey: .twitterLanguage)
    }
}

// MARK: *** 数据版本管理 ***

extension ATUserSettingTool {
    ///数据版本管理
    private struct DataVersion: UserDefaultsSettable {
        enum defaultKeys: String {
            ///海域数据版本
            case area
        }
    }
}

// MARK: *** APP描述 ***

extension ATUserSettingTool {
    ///APP描述
    private struct AppDesc: UserDefaultsSettable {
        enum defaultKeys: String {
            ///是否首次进入APP Bool
            case notFirstUse
            ///版本号 String
            case versionString
        }
    }
    
    ///获取用户是否首次进入APP
    class func getIsFirstTimeUse() -> Bool {
        let notFirstUse = AppDesc.bool(forKey: .notFirstUse)
        
        return !notFirstUse
    }
    ///设置用户是否首次进入APP为false
    class func setIsFirstTimeUseToFalse() {
        AppDesc.set(true, forKey: .notFirstUse)
    }
    
    ///判断是否更新了版本
    class func isUpdated() -> Bool {
        let currentVersionString = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        if let savedVersionString = AppDesc.string(forKey: .versionString) {
            if savedVersionString == currentVersionString {
                return false
            } else {
                AppDesc.set(currentVersionString, forKey: .versionString)
                return true
            }
        } else {
            AppDesc.set(currentVersionString, forKey: .versionString)
            return true
        }
    }
}
