//
//  ATImagePageViewController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/20.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit
import Photos

class ATImagePageViewController: UIPageViewController {
    
    ///图片URL列表
    var avatarURLList: [URL?] = []
    ///最初所选URL索引
    var initialIndex: Int = 0 {
        didSet {
            if initialIndex < 0 {
                initialIndex = 0
            } else if initialIndex >= avatarURLList.count - 1 {
                initialIndex = avatarURLList.count - 1
            }
            setViewControllers([ATImageViewController(image: avatarURLList[initialIndex])], direction: .forward, animated: true)
            currentIndex = initialIndex
        }
    }
    ///当前所选URL索引
    private var currentIndex: Int = 0 {
        didSet {
            let frontPart = "\(currentIndex + 1)"
            let latterPart = " / \(avatarURLList.count)"
            
            let attStr = NSMutableAttributedString(string: frontPart + latterPart)
            attStr.addAttributes([NSAttributedStringKey.font: UIFont.largeTitle], range: NSRange(location: 0, length: frontPart.count))
            attStr.addAttributes([NSAttributedStringKey.font: UIFont.title2], range: NSRange(location: frontPart.count, length: latterPart.count))
            
            indexLbl.attributedText = attStr
        }
    }
    
    private lazy var indexLbl: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        self.dataSource = self
        self.delegate = self
        
        let dismissBtn = UIButton(type: .custom)
        dismissBtn.backgroundColor = .gray
        dismissBtn.addTarget(self, action: #selector(dismissBtnDidClick), for: .touchUpInside)
        dismissBtn.adjustsImageWhenHighlighted = false
        
        let saveImageBtn = UIButton(type: .custom)
        saveImageBtn.backgroundColor = .gray
        saveImageBtn.addTarget(self, action: #selector(saveImageBtnDidClick), for: .touchUpInside)
        saveImageBtn.adjustsImageWhenHighlighted = false
        
        view.addSubview(dismissBtn)
        view.addSubview(indexLbl)
        view.addSubview(saveImageBtn)
        
        dismissBtn.snp.makeConstraints { (make) in
            make.top.equalTo(Constant.ui.size.statusBarHeight)
            make.left.equalTo(10.0)
            make.size.equalTo(CGSize(width: 50.0, height: 50.0))
        }
        indexLbl.snp.makeConstraints { (make) in
            make.left.equalTo(10.0)
            make.bottom.equalTo(-Constant.ui.size.bottomSafePadding - 10.0)
        }
        saveImageBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-10.0)
            make.bottom.equalTo(-Constant.ui.size.bottomSafePadding - 10.0)
            make.size.equalTo(CGSize(width: 50.0, height: 50.0))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
    }
    
    @objc private func dismissBtnDidClick(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func saveImageBtnDidClick(_ sender: UIButton) {
        ATPermissionsTool.getPhotoPermissions { (status) in
            if status == .authorized || status == .notDetermined {
                let url = self.avatarURLList[self.currentIndex]
                SDWebImageManager.shared().imageDownloader?.downloadImage(with: url, options: [.continueInBackground, .progressiveDownload], progress: nil, completed: { (image, data, error, finished) in
                    if finished {
                        if let image = image {
                            PHPhotoLibrary.shared().performChanges({
                                PHAssetChangeRequest.creationRequestForAsset(from: image)
                            }, completionHandler: { (success, saveError) in
                                if success {
                                    print("保存成功")
                                } else {
                                    print("保存失败")
                                    print(String(describing: saveError?.localizedDescription))
                                }
                            })
                        }
                    }
                })
            } else {
                print("无权保存")
            }
        }
    }
    
    private func index(of viewController: ATImageViewController) -> Int? {
        return avatarURLList.index(where: { (url) -> Bool in
            viewController.imageURL == url
        })
    }
}

extension ATImagePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentIndex = index(of: viewController as! ATImageViewController) {
            if currentIndex >= avatarURLList.count - 1 {
                return nil
            } else {
                return ATImageViewController(image: avatarURLList[currentIndex + 1])
            }
        } else {
            return nil
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentIndex = index(of: viewController as! ATImageViewController) {
            if currentIndex <= 0 {
                return nil
            } else {
                return ATImageViewController(image: avatarURLList[currentIndex - 1])
            }
        } else {
            return nil
        }
    }
    
}

extension ATImagePageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let willIndex = index(of: pendingViewControllers.first as! ATImageViewController) {
            currentIndex = willIndex
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            if let willIndex = index(of: previousViewControllers.first as! ATImageViewController) {
                currentIndex = willIndex
            }
        }
    }
}

private class ATImageViewController: UIViewController {
    
    ///图片链接
    fileprivate var imageURL: URL?
    
    private lazy var imageView: UIImageView = {
        let imv = UIImageView()
        
        imv.contentMode = .scaleAspectFit
        
        return imv
    }()
    
    convenience init(image url: URL?) {
        self.init()
        
        self.imageURL = url
    }
    
    override func viewDidLoad() {
        
        view.backgroundColor = .black
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        imageView.sd_setImage(with: imageURL)
    }
}






