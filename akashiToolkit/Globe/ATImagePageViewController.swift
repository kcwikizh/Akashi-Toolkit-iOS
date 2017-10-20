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

class ATImagePageViewController: UIPageViewController {
    
    ///图片URL列表
    var avatarURLList: [URL?] = []
    ///当前所选URL索引
    var currentIndex: Int = 0 {
        didSet {
            if currentIndex < 0 {
                currentIndex = 0
            } else if currentIndex >= avatarURLList.count - 1 {
                currentIndex = avatarURLList.count - 1
            }
            setViewControllers([ATImageViewController(image: avatarURLList[currentIndex])], direction: .forward, animated: true)
            setIndexLblText(currentIndex)
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
        
        view.addSubview(dismissBtn)
        view.addSubview(indexLbl)
        
        dismissBtn.snp.makeConstraints { (make) in
            make.top.equalTo(Constant.ui.size.statusBarHeight)
            make.left.equalTo(10.0)
            make.size.equalTo(CGSize(width: 50.0, height: 50.0))
        }
        indexLbl.snp.makeConstraints { (make) in
            make.left.equalTo(10.0)
            make.bottom.equalTo(Constant.ui.size.bottomSafePadding - 10.0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        SDImageCache.shared().clearDisk()
        SDImageCache.shared().clearMemory()
    }
    
    @objc private func dismissBtnDidClick(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private func index(of viewController: ATImageViewController) -> Int? {
        return avatarURLList.index(where: { (url) -> Bool in
            viewController.imageURL == url
        })
    }
    
    private func setIndexLblText(_ index: Int) {
        let frontPart = "\(index + 1)"
        let latterPart = " / \(avatarURLList.count)"
        
        let attStr = NSMutableAttributedString(string: frontPart + latterPart)
        attStr.addAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 35.0)], range: NSRange(location: 0, length: frontPart.count))
        attStr.addAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 25.0)], range: NSRange(location: frontPart.count, length: latterPart.count))
        
        indexLbl.attributedText = attStr
    }
}

extension ATImagePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentIndex = index(of: viewController as! ATImageViewController) {
            setIndexLblText(currentIndex)
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
            setIndexLblText(currentIndex)
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
        
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        imageView.sd_setImage(with: imageURL)
    }
}






