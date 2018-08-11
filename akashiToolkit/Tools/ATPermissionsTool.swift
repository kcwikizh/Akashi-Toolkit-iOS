//
//  ATPermissionsTool.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/21.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit
import SDWebImage
import Photos

enum ATPermissionsStatus {
    ///已拒绝
    case denied
    ///无权 (例如家长控制等
    case restricted
    ///已授权
    case authorized
    ///未选择
    case notDetermined
    
    fileprivate init(_ photoAuthorizationStatus: PHAuthorizationStatus) {
        switch photoAuthorizationStatus {
        case .denied:
            self = .denied
        case .restricted:
            self = .restricted
        case .authorized:
            self = .authorized
        case .notDetermined:
            self = .notDetermined
        }
    }
}

final class ATPermissionsTool {
    typealias ATPermissionsCompletionHandler = (_ status: ATPermissionsStatus) -> Void
}

// MARK: *** Photo ***

extension ATPermissionsTool {
    
    ///获取相册权限
    private class func getPhotoPermissions(_ handler: @escaping ATPermissionsCompletionHandler) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .denied:
            ///已拒绝
            let alert = UIAlertController(title: "无相册权限", message: "请在iPhone的\"设置-隐私-照片\"中允许访问照片。", preferredStyle: .alert)
            let done = UIAlertAction(title: "确定", style: .default) { _ in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
            let cancle = UIAlertAction(title: "取消", style: .default)
            alert.addAction(done)
            alert.addAction(cancle)
            UIViewController.currentPresented?.present(alert, animated: true) {
                handler(.denied)
            }
        case .restricted:
            ///无权
            let alert = UIAlertController(title: "无相册权限", message: "本应用程序无权访问相册。", preferredStyle: .alert)
            let done = UIAlertAction(title: "确定", style: .default)
            alert.addAction(done)
            UIViewController.currentPresented?.present(alert, animated: true) {
                handler(.restricted)
            }
        case .authorized:
            ///已授权
            handler(.authorized)
        case .notDetermined:
            ///未选择
            PHPhotoLibrary.requestAuthorization({ (status) in
                handler(ATPermissionsStatus(status))
            })
        }
    }
    
    ///根据URL保存图片到本地相册
    class func saveImage(with url: URL?, completed: @escaping (_ resultDescription: String) -> Void) {
        getPhotoPermissions { (status) in
            if status == .authorized || status == .notDetermined {
                SDWebImageManager.shared().imageDownloader?.downloadImage(with: url, options: [.continueInBackground, .progressiveDownload], progress: nil, completed: { (image, data, error, finished) in
                    if finished {
                        if let image = image {
                            PHPhotoLibrary.shared().performChanges({
                                PHAssetChangeRequest.creationRequestForAsset(from: image)
                            }, completionHandler: { (success, saveError) in
                                if success {
                                    completed("保存成功")
                                } else {
                                    completed("保存失败")
                                }
                            })
                        } else {
                            completed("图片下载错误")
                        }
                    }
                })
            } else {
                completed("获取相册权限失败")
            }
        }
    }
}
