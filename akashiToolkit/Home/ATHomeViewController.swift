//
//  ATHomeViewController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/9.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit
import SnapKit

class ATHomeViewController: UIViewController {
    
    /// MARK: *** 属性 ***
    
    private var dataList: [ATHomeDataModel] = {
        var list: [ATHomeDataModel] = []
        
        list.append(ATHomeDataModel(imageName: "sign", title: "推特"))
        list.append(ATHomeDataModel(imageName: "sign", title: "主页"))
        list.append(ATHomeDataModel(imageName: "sign", title: "活动"))
        
        return list
    }()
    
    private var currentPageIndex: Int = 1 {
        willSet {
            if currentPageIndex != newValue && newValue <= dataList.count - 1 {
                title = dataList[newValue].title
            }
        }
    }
    
    private lazy var pageTabView: LSPageTabView = {
        let view = LSPageTabView(type: .stationary)
        
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    /// MARK: *** 周期 ***
    
    override func viewDidLoad() {
        title = "主页"
        
        view.addSubview(pageTabView)
        
        pageTabView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(0)
        }
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 100, y: 200, width: 50, height: 50)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(touchesBtn), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc func touchesBtn() {
//        ATAPIClient<ATTwitterModel>().fetchTwitterList(count: 3) { (twitterList, error) in
//            if let list = twitterList {
//                for tw in list {
//                    print("\(tw.dateStr) - \(tw.jpContent) - \(tw.zhContent)")
//                    print("\(tw.imageURLStr)")
//                }
//            }
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        pageTabView.selectedTab(at: currentPageIndex, animated: false)
    }
    
    /// MARK: *** 回调 ***
    
    @objc private func panOnScreenEdge(gesture: UIScreenEdgePanGestureRecognizer) {
        print("larry sue : \(gesture.state)")
    }
}

extension ATHomeViewController: LSPageTabViewDataSource {
    func numberOfTab(in pageTabView: LSPageTabView) -> Int {
        return dataList.count
    }
    
    func pageTabView(_ pageTabView: LSPageTabView, childViewAt index: Int) -> UIView {
        let view = UIView()
        
        if index % 2 == 0 {
            view.backgroundColor = .darkGray
        } else {
            view.backgroundColor = .brown
        }
        
        return view
    }
    
    func pageTabView(_ pageTabView: LSPageTabView, selectedTitleViewForTabAt index: Int) -> UIView {
        let imv = UIImageView()
        
        imv.image = dataList[index].icon?.scaleImage(scaleSize: 0.2).withRenderingMode(.alwaysTemplate)
        imv.contentMode = .center
        imv.tintColor = .black
        
        return imv
    }
    func pageTabView(_ pageTabView: LSPageTabView, unselectedTitleViewForTabAt index: Int) -> UIView {
        let imv = UIImageView()
        
        imv.image = dataList[index].icon?.scaleImage(scaleSize: 0.2).withRenderingMode(.alwaysTemplate)
        imv.contentMode = .center
        imv.tintColor = .lightGray
        
        return imv
    }
}

extension ATHomeViewController: LSPageTabViewDelegate {
    func pageTabViewDidScroll(_ pageTabView: LSPageTabView) {
        let x = pageTabView.contentOffset.x

        currentPageIndex = Int(x / view.width + 0.5)
    }
}

fileprivate class ATHomeDataModel: NSObject {
    var icon: UIImage?
    var title: String?
    
    convenience init(imageName: String, title: String) {
        self.init()
        
        self.icon = UIImage(named: imageName)
        self.title = title
    }
}






