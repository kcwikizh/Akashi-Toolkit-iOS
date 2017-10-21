//
//  ATAvatarListViewController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/19.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

private let ATAvatarListViewCellIdentifier = "ATAvatarListViewCellIdentifier"

class ATAvatarListViewController: UIViewController {
    
    private var avatarURLList: [URL?] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.width * 0.5, height: UIScreen.width * 0.5)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = Constant.ui.color.lightPageBackground
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    override func viewDidLoad() {
        title = "历史头像"
        view.backgroundColor = Constant.ui.color.lightPageBackground
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        collectionView.register(ATAvatarListViewCell.self, forCellWithReuseIdentifier: ATAvatarListViewCellIdentifier)
        
        ATAPIClient.getAvatarList { (urlList, error) in
            if let urlList = urlList {
                self.avatarURLList = urlList
                self.collectionView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
    }
}

extension ATAvatarListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avatarURLList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ATAvatarListViewCellIdentifier, for: indexPath) as! ATAvatarListViewCell
        
        cell.imageURL = avatarURLList[indexPath.row]
        
        return cell
    }
}

extension ATAvatarListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ATImagePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        vc.avatarURLList = avatarURLList
        vc.initialIndex = indexPath.row
        
        present(vc, animated: true)
    }
}

private class ATAvatarListViewCell: UICollectionViewCell {
    ///图片链接
    var imageURL: URL? {
        didSet {
            imageView.sd_setImage(with: imageURL)
        }
    }
    
    private lazy var imageView: UIImageView = {
        let imv = UIImageView()
        
        imv.backgroundColor = Constant.ui.color.lightPageBackground
        
        return imv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

