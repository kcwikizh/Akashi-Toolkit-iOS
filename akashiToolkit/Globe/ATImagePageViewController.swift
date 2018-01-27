//
//  ATImagePageViewController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/20.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit
import Photos
import SDWebImage

class ATImagePageViewController: UIPageViewController {
    
    // MARK: *** 属性 ***
    
    ///状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
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
            
            ///设置字体
            attStr.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: 35.0), range: NSRange(location: 0, length: frontPart.count))
            attStr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 25.0), range: NSRange(location: frontPart.count, length: latterPart.count))
            ///设置阴影
            let shadow = NSShadow()
            shadow.shadowColor = UIColor(white: 0, alpha: 0.5)
            shadow.shadowOffset = CGSize(width: 2.0, height: 2.0)
            shadow.shadowBlurRadius = 2.0
            attStr.addAttribute(NSAttributedStringKey.shadow, value: shadow, range: NSRange(location: 0, length: attStr.string.count))
            
            indexLbl.attributedText = attStr
        }
    }
    ///索引文字
    private lazy var indexLbl: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    ///下载图片按钮
    private lazy var downloadImageBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(white: 0, alpha: 0.5)
        button.layer.cornerRadius = 20.0
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(downloadImageBtnDidClick), for: .touchUpInside)
        
        let saveImageIcon = UIImage(named: "download")?.resizeImage(to: CGSize(width: 20.0, height: 20.0)).withRenderingMode(.alwaysTemplate)
        button.setImage(saveImageIcon, for: .normal)
        button.tintColor = .white
        
        return button
    }()
    ///菊花
    private lazy var chrysanthemum: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .white)
    ///下载状态
    private var isDownloading: Bool = false {
        didSet {
            if isDownloading {
                self.downloadImageBtn.isHidden = true
                self.chrysanthemum.startAnimating()
            } else {
                self.downloadImageBtn.isHidden = false
                self.chrysanthemum.stopAnimating()
            }
        }
    }
    
    // MARK: *** 周期 ***
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        self.dataSource = self
        self.delegate = self
        
        let dismissBtn = UIButton(type: .custom)
        dismissBtn.backgroundColor = UIColor(white: 0, alpha: 0.5)
        dismissBtn.layer.cornerRadius = 20.0
        dismissBtn.layer.masksToBounds = true
        dismissBtn.addTarget(self, action: #selector(dismissBtnDidClick), for: .touchUpInside)
        dismissBtn.adjustsImageWhenHighlighted = false
        
        let dismissIcon = UIImage(named: "close")?.resizeImage(to: CGSize(width: 15.0, height: 15.0)).withRenderingMode(.alwaysTemplate)
        dismissBtn.setImage(dismissIcon, for: .normal)
        dismissBtn.tintColor = .white
        
        view.addSubview(dismissBtn)
        view.addSubview(indexLbl)
        view.addSubview(downloadImageBtn)
        view.addSubview(chrysanthemum)
        
        dismissBtn.snp.makeConstraints { (make) in
            make.top.equalTo(Constant.ui.size.statusBarHeight + 10)
            make.left.equalTo(15.0)
            make.size.equalTo(CGSize(width: 40.0, height: 40.0))
        }
        indexLbl.snp.makeConstraints { (make) in
            make.left.equalTo(15.0)
            make.bottom.equalTo(-Constant.ui.size.bottomSafePadding - 15.0)
        }
        downloadImageBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-15.0)
            make.bottom.equalTo(-Constant.ui.size.bottomSafePadding - 15.0)
            make.size.equalTo(CGSize(width: 40.0, height: 40.0))
        }
        chrysanthemum.snp.makeConstraints { (make) in
            make.size.equalTo(downloadImageBtn)
            make.center.equalTo(downloadImageBtn)
        }
    }
    
    // MARK: *** 内存警告 ***

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        SDImageCache.shared().clearMemory()
    }
    
    // MARK: *** 回调 ***
    
    @objc private func dismissBtnDidClick(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func downloadImageBtnDidClick(_ sender: UIButton) {
        isDownloading = true
        
        let url = self.avatarURLList[self.currentIndex]
        ATPermissionsTool.saveImage(with: url) { (resultDescription) in
            runInMain {
                ATToastMessageTool.show(resultDescription)
                self.isDownloading = false
            }
        }
    }
    
    // MARK: *** 逻辑 ***
    
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
        
        imv.backgroundColor = .black
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






