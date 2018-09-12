//
//  HomeViewController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/9.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: BaseViewController {
    
    /// MARK: *** 属性 ***
    
    private let disposeBag = DisposeBag()
    
    private var itemList: [HomeItemModel] = {
        var list: [HomeItemModel] = []
        
        list.append(HomeItemModel(imageName: "sign", title: "主页"))
        list.append(HomeItemModel(imageName: "sign", title: "官推"))
        list.append(HomeItemModel(imageName: "sign", title: "活动"))
        
        return list
    }()
    
    private var menuItemList: [HomeMenuItemModel] = {
        var list: [HomeMenuItemModel] = []
        
        list.append(HomeMenuItemModel(imageName: "sign", title: "改修工厂", controller: ATImproveViewController.init))
        list.append(HomeMenuItemModel(imageName: "sign", title: "装备", controller: ATEquipmentViewController.init))
        list.append(HomeMenuItemModel(imageName: "sign", title: "舰娘", controller: ATShipViewController.init))
        list.append(HomeMenuItemModel(imageName: "sign", title: "海域", controller: ATAreaViewController.init))
        list.append(HomeMenuItemModel(imageName: "sign", title: "深海栖舰", controller: ATEnemyViewController.init))
        list.append(HomeMenuItemModel(imageName: "sign", title: "任务", controller: ATMissionViewController.init))
        list.append(HomeMenuItemModel(imageName: "sign", title: "远征", controller: ATExpeditionViewController.init))
        list.append(HomeMenuItemModel(imageName: "sign", title: "工具箱", controller: ATToolboxViewController.init))
//        list.append(HomeMenuItemModel(imageName: "sign", title: "设置", controller: ATSettingViewController.init))
//        list.append(HomeMenuItemModel(imageName: "sign", title: "关于", controller: ATAboutViewController.init))
        
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
        
        view.tabBarColor = Constant.UI.Color.theme
        view.sliderColor = Constant.UI.Color.lightForeground
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    private lazy var avatarListPageBtn: UIButton = {
        let button = UIButton(type: .custom)
        
        button.isHidden = true
        button.setTitle("历史头像", for: UIControl.State.normal)
        button.setTitleColor(Constant.UI.Color.lightForeground, for: UIControl.State.normal)
        button.titleLabel?.font = .subheadline
        button.rx.tap.bind {[unowned self] in
            self.navigationController?.pushViewController(ATAvatarListViewController(), animated: true)
        }.disposed(by: disposeBag)
        
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
        leftBtn.setImage(image, for: UIControl.State.normal)
        leftSubscribe?.dispose()
        leftSubscribe = leftBtn.rx.tap.subscribe(onNext: { [unowned self] in
            self.expandMenu(animaRate: 1.0)
        })
        
        navView.addSubview(avatarListPageBtn)
        view.addSubview(pageTabView)
        view.addSubview(maskView)
        view.addSubview(menuView)

        avatarListPageBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(rightBtn)
            make.right.equalTo(-Constant.UI.Size.navItemHorizontalPadding)
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
        
        ///屏幕边缘侧滑手势
        screenEdgePan = UIScreenEdgePanGestureRecognizer()
        screenEdgePan?.edges = .left
        screenEdgePan?.rx.event.subscribe(onNext: { [unowned self] gr in
            let maxOffset = self.menuView.width
            let offsetX = min(gr.location(in: self.view).x, maxOffset)
            let offsetRate = offsetX / maxOffset
            
            switch gr.state {
            case .began, .changed, .possible:
                self.menuView.transform = CGAffineTransform(translationX: offsetX, y: 0)
                self.maskView.alpha = offsetRate
            case .ended, .cancelled, .failed:
                if offsetRate > 0.5 {
                    self.expandMenu(animaRate: offsetRate)
                } else {
                    self.contractMenu(animaRate: offsetRate)
                }
            }
        }).disposed(by: disposeBag)
        ///点击遮罩范围收起菜单
        maskTap = UITapGestureRecognizer()
        maskTap?.rx.event.subscribe(onNext: { [unowned self] _ in
            self.contractMenu(animaRate: 1.0)
        }).disposed(by: disposeBag)
        
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

extension HomeViewController: LSPageTabViewDataSource {
    func numberOfTab(in pageTabView: LSPageTabView) -> Int {
        return itemList.count
    }
    
    func pageTabView(_ pageTabView: LSPageTabView, childViewAt index: Int) -> UIView {
        let view = UIView()
        
        if index % 2 == 0 {
            view.backgroundColor = Constant.UI.Color.lightBackground
        } else {
            view.backgroundColor = Constant.UI.Color.darkBackground
        }
        
        return view
    }
    
    func pageTabView(_ pageTabView: LSPageTabView, selectedTitleViewForTabAt index: Int) -> UIView {
        let imv = UIImageView()
        
        imv.image = itemList[index].icon?.scaleImage(to: 0.2).withRenderingMode(.alwaysTemplate)
        imv.contentMode = .center
        imv.tintColor = Constant.UI.Color.lightForeground
        
        return imv
    }
    func pageTabView(_ pageTabView: LSPageTabView, unselectedTitleViewForTabAt index: Int) -> UIView {
        let imv = UIImageView()
        
        imv.image = itemList[index].icon?.scaleImage(to: 0.2).withRenderingMode(.alwaysTemplate)
        imv.contentMode = .center
        imv.tintColor = Constant.UI.Color.lightForeground
        imv.alpha = 0.7
        
        return imv
    }
}

extension HomeViewController: LSPageTabViewDelegate {
    func pageTabViewDidScroll(_ pageTabView: LSPageTabView) {
        let x = pageTabView.contentOffset.x

        currentPageIndex = Int(x / view.width + 0.5)
    }
}

extension HomeViewController: ATHomeMenuViewDelegate {
    func homeMenuView(_ homeMenuView: ATHomeMenuView, didSelectItemAt index: Int) {
        let targetVc = menuItemList[index].controller()
        targetVc.title = menuItemList[index].title
        
        if index == menuItemList.count - 1 {
            ///最后一项是about 用过场动画切换
            present(targetVc, animated: true)
        } else {
            ///其他使用普通push
            navigationController?.pushViewController(targetVc, animated: true)
        }
    }
}

fileprivate struct HomeItemModel {
    var icon: UIImage?
    var title: String?
    
    init(imageName: String, title: String) {
        self.icon = UIImage(named: imageName)
        self.title = title
    }
}

struct HomeMenuItemModel {
    var icon: UIImage?
    var title: String?
    var controller: () -> BaseViewController
    
    init(imageName: String, title: String, controller: @escaping () -> BaseViewController) {
        self.icon = UIImage(named: imageName)
        self.title = title
        self.controller = controller
    }
}






