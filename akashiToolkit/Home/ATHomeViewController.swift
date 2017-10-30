//
//  ATHomeViewController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/9.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

class ATHomeViewController: ATBaseViewController {
    
    /// MARK: *** 属性 ***
    
    private var itemList: [ATHomeItemModel] = {
        var list: [ATHomeItemModel] = []
        
        list.append(ATHomeItemModel(imageName: "sign", title: "主页"))
        list.append(ATHomeItemModel(imageName: "sign", title: "官推"))
        list.append(ATHomeItemModel(imageName: "sign", title: "活动"))
        
        return list
    }()
    
    private var menuItemList: [ATHomeMenuItemModel] = {
        var list: [ATHomeMenuItemModel] = []
        
        list.append(ATHomeMenuItemModel(imageName: "sign", title: "改修工厂", controller: ATImproveViewController.self))
        list.append(ATHomeMenuItemModel(imageName: "sign", title: "装备", controller: ATEquipmentViewController.self))
        list.append(ATHomeMenuItemModel(imageName: "sign", title: "舰娘", controller: ATShipViewController.self))
        list.append(ATHomeMenuItemModel(imageName: "sign", title: "海域", controller: ATAreaViewController.self))
        list.append(ATHomeMenuItemModel(imageName: "sign", title: "深海栖舰", controller: ATEnemyViewController.self))
        list.append(ATHomeMenuItemModel(imageName: "sign", title: "任务", controller: ATMissionViewController.self))
        list.append(ATHomeMenuItemModel(imageName: "sign", title: "远征", controller: ATExpeditionViewController.self))
        list.append(ATHomeMenuItemModel(imageName: "sign", title: "工具箱", controller: ATToolboxViewController.self))
        list.append(ATHomeMenuItemModel(imageName: "sign", title: "设置", controller: ATSettingViewController.self))
        list.append(ATHomeMenuItemModel(imageName: "sign", title: "关于", controller: ATAboutViewController.self))
        
        return list
    }()
    
    private var currentPageIndex: Int = 0 {
        didSet {
            if oldValue != currentPageIndex && currentPageIndex <= itemList.count - 1 {
                title = itemList[currentPageIndex].title
                
                if currentPageIndex == 1 {
                    avatarListPageBtn.isHidden = false
                    rightBtn.isHidden = false
                } else {
                    avatarListPageBtn.isHidden = true
                    rightBtn.isHidden = true
                }
            }
        }
    }
    
    private lazy var pageTabView: LSPageTabView = {
        let view = LSPageTabView(type: .stationary)
        
        view.tabBarColor = Constant.ui.color.navigationBar
        view.sliderColor = .white
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    private lazy var avatarListPageBtn: UIButton = {
        let button = UIButton(type: .custom)
        
        button.isHidden = true
        button.setTitle("历史头像", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .subheadline
        button.addTarget(self, action: #selector(rightBtnDidClick), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var menuView: ATHomeMenuView = {
        let menu = ATHomeMenuView()
        
        menu.delegate = self
        
        return menu
    }()
    private lazy var maskView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.alpha = 0.0
        
        return view
    }()
    
    private var screenEdgePan: UIScreenEdgePanGestureRecognizer?
    private var maskTap: UITapGestureRecognizer?
    
    /// MARK: *** 周期 ***
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "主页"
        rightBtn.isHidden = true
        
        let image = UIImage(named: "menu")?.resizeImage(to: CGSize(width: 20.0, height: 15.0)).withRenderingMode(.alwaysTemplate)
        leftBtn.setImage(image, for: .normal)
        
        view.backgroundColor = Constant.ui.color.lightBackground
        
        navView.addSubview(avatarListPageBtn)
        view.addSubview(pageTabView)
        view.addSubview(maskView)
        view.addSubview(menuView)

        avatarListPageBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(rightBtn)
            make.right.equalTo(-Constant.ui.size.navItemHorizontalPadding)
        }
        pageTabView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(navView.snp.bottom)
        }
        maskView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        menuView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.left.equalTo(-UIScreen.width * 0.4)
            make.width.equalTo(UIScreen.width * 0.4)
        }
        
        screenEdgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(panOnScreenEdge))
        screenEdgePan?.edges = .left
        maskTap = UITapGestureRecognizer(target: self, action: #selector(tapOnMaskView))
        
        view.addGestureRecognizer(screenEdgePan!)
        maskView.addGestureRecognizer(maskTap!)
        
        menuView.itemList = menuItemList
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        pageTabView.selectedTab(at: currentPageIndex, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        menuView.transform = CGAffineTransform.identity
        menuView.listView.contentOffset = CGPoint(x: 0, y: UIScreen.height * 0.5)
        maskView.alpha = 0.0
        screenEdgePan!.isEnabled = true
    }
    
    /// MARK: *** 回调 ***
    
    @objc private func panOnScreenEdge(gesture: UIScreenEdgePanGestureRecognizer) {
        
        let maxOffset = menuView.width
        let offsetX = min(gesture.location(in: view).x, maxOffset)
        let offsetRate = offsetX / maxOffset
        
        switch gesture.state {
        case .began, .changed, .possible:
            menuView.transform = CGAffineTransform(translationX: offsetX, y: 0)
            maskView.alpha = offsetRate
        case .ended, .cancelled, .failed:
            if offsetRate > 0.5 {
                expandMenu(animaRate: offsetRate)
            } else {
                contractMenu(animaRate: offsetRate)
            }
        }
    }
    @objc private func tapOnMaskView() {
        contractMenu(animaRate: 1.0)
    }
    override func leftBtnDidClick() {
        expandMenu(animaRate: 1.0)
    }
    override func rightBtnDidClick() {
        super.rightBtnDidClick()
        navigationController?.pushViewController(ATAvatarListViewController(), animated: true)
    }
    
    /// MARK: *** 逻辑 ***
    
    ///展开菜单
    private func expandMenu(animaRate: CGFloat) {
        self.screenEdgePan!.isEnabled = false
        UIView.animate(withDuration: TimeInterval(0.2 * animaRate), animations: {
            self.menuView.transform = CGAffineTransform(translationX: self.menuView.width, y: 0)
            self.maskView.alpha = 1.0
        }) { (finished) in
            if finished {
                self.maskTap!.isEnabled = true
            }
        }
    }
    ///收起菜单
    private func contractMenu(animaRate: CGFloat) {
        self.maskTap!.isEnabled = false
        UIView.animate(withDuration: TimeInterval(0.2 * animaRate), animations: {
            self.menuView.transform = CGAffineTransform.identity
            self.maskView.alpha = 0.0
        }) { (finished) in
            if finished {
                self.screenEdgePan!.isEnabled = true
                self.menuView.listView.contentOffset = CGPoint(x: 0, y: UIScreen.height * 0.5)
            }
        }
    }
}

extension ATHomeViewController: LSPageTabViewDataSource {
    func numberOfTab(in pageTabView: LSPageTabView) -> Int {
        return itemList.count
    }
    
    func pageTabView(_ pageTabView: LSPageTabView, childViewAt index: Int) -> UIView {
        let view = UIView()
        
        if index % 2 == 0 {
            view.backgroundColor = Constant.ui.color.lightBackground
        } else {
            view.backgroundColor = Constant.ui.color.darkBackground
        }
        
        return view
    }
    
    func pageTabView(_ pageTabView: LSPageTabView, selectedTitleViewForTabAt index: Int) -> UIView {
        let imv = UIImageView()
        
        imv.image = itemList[index].icon?.scaleImage(to: 0.2).withRenderingMode(.alwaysTemplate)
        imv.contentMode = .center
        imv.tintColor = .white
        
        return imv
    }
    func pageTabView(_ pageTabView: LSPageTabView, unselectedTitleViewForTabAt index: Int) -> UIView {
        let imv = UIImageView()
        
        imv.image = itemList[index].icon?.scaleImage(to: 0.2).withRenderingMode(.alwaysTemplate)
        imv.contentMode = .center
        imv.tintColor = .white
        imv.alpha = 0.7
        
        return imv
    }
}

extension ATHomeViewController: LSPageTabViewDelegate {
    func pageTabViewDidScroll(_ pageTabView: LSPageTabView) {
        let x = pageTabView.contentOffset.x

        currentPageIndex = Int(x / view.width + 0.5)
    }
}

extension ATHomeViewController: ATHomeMenuViewDelegate {
    func homeMenuView(_ homeMenuView: ATHomeMenuView, didSelectItemAt index: Int) {
        let targetVc = menuItemList[index].controller!.init()
        targetVc.title = menuItemList[index].title
        
        navigationController?.pushViewController(targetVc, animated: true)
    }
}

fileprivate class ATHomeItemModel: NSObject {
    var icon: UIImage?
    var title: String?
    
    convenience init(imageName: String, title: String) {
        self.init()
        
        self.icon = UIImage(named: imageName)
        self.title = title
    }
}

class ATHomeMenuItemModel: NSObject {
    var icon: UIImage?
    var title: String?
    var controller: ATBaseViewController.Type?
    
    convenience init(imageName: String, title: String, controller: ATBaseViewController.Type) {
        self.init()
        
        self.icon = UIImage(named: imageName)
        self.title = title
        self.controller = controller
    }
}






