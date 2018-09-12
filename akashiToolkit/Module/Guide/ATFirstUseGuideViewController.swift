//
//  ATFirstUseGuideViewController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/12/31.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

class ATFirstUseGuideViewController: BaseViewController {
    
    // MARK: *** 属性 ***
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private lazy var appLogoImv: UIImageView = UIImageView(image: UIImage(named: "appLogo")?.resizeImage(to: CGSize(width: 100.0, height: 100.0)))
    private lazy var organizationLogoImv: UIImageView = UIImageView(image: UIImage(named: "organizationLogo")?.resizeImage(to: CGSize(width: 85.0, height: 85.0)))
    
    private lazy var welcomeLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.title2
        label.textColor = Constant.UI.Color.theme
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "亲爱的提督\n欢迎您下载使用明石工具箱\n\n现在为您进行本地数据初始化\n这可能需要几分钟的时间"
        
        return label
    }()
    
    private lazy var networkTipsLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.footnote
        label.textColor = Constant.UI.Color.theme
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "* 建议在WiFi环境下操作"
        
        return label
    }()
    
    private lazy var startDownloadBtn: UIButton = {
        let button = UIButton(type: .custom)
        
        button.backgroundColor = Constant.UI.Color.theme
        button.layer.cornerRadius = 3.0
        button.layer.masksToBounds = true
        button.setTitle("开始", for: UIControl.State.normal)
        button.setTitleColor(Constant.UI.Color.lightForeground, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(startDownloadBtnDidClick), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    private lazy var shipLoadView = ATCategoryCheckView(title: "舰娘")
    private lazy var equipmentLoadView = ATCategoryCheckView(title: "装备")
    private lazy var areaLoadView = ATCategoryCheckView(title: "海域")
    private lazy var missionLoadView = ATCategoryCheckView(title: "任务")
    private lazy var expeditionLoadView = ATCategoryCheckView(title: "远征")
    private lazy var enemyLoadView = ATCategoryCheckView(title: "深海栖舰")
    private lazy var improveLoadView = ATCategoryCheckView(title: "改修工厂")
    
    ///转场至首页所用的背景过渡view
    private lazy var animaBgView: UIView = {
        let view = UIView()
        
        view.backgroundColor = Constant.UI.Color.lightBackground
        view.alpha = 0.0
        
        return view
    }()
    
    private var loadProcess = 0 {
        didSet {
            if loadProcess == 7 {
                UserSettingTool.setIsFirstTimeUseToFalse()
                UIView.animate(withDuration: 0.4, delay: 0.8, animations: {
                    self.appLogoImv.alpha = 0.0
                    self.organizationLogoImv.alpha = 0.0
                    
                    self.shipLoadView.alpha = 0.0
                    self.equipmentLoadView.alpha = 0.0
                    self.areaLoadView.alpha = 0.0
                    self.missionLoadView.alpha = 0.0
                    self.expeditionLoadView.alpha = 0.0
                    self.enemyLoadView.alpha = 0.0
                    self.improveLoadView.alpha = 0.0
                    
                    self.animaBgView.alpha = 1.0
                }, completion: { (finished) in
                    if finished {
                        Constant.window.rootViewController = BaseNavigationController(rootViewController: HomeViewController())
                    }
                })
            }
        }
    }
    
    // MARK: *** 周期 ***

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constant.UI.Color.lightForeground
        navView.isHidden = true
        leftBtn.isHidden = true
        
        view.addSubview(animaBgView)
        view.addSubview(appLogoImv)
        view.addSubview(organizationLogoImv)
        view.addSubview(welcomeLbl)
        view.addSubview(networkTipsLbl)
        view.addSubview(startDownloadBtn)
        
        view.addSubview(shipLoadView)
        view.addSubview(equipmentLoadView)
        view.addSubview(areaLoadView)
        view.addSubview(missionLoadView)
        view.addSubview(expeditionLoadView)
        view.addSubview(enemyLoadView)
        view.addSubview(improveLoadView)
        
        animaBgView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        appLogoImv.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100.0, height: 100.0))
            make.centerX.equalTo(self.view).offset(-80.0)
            make.top.equalTo(UIScreen.height * 0.15)
        }
        organizationLogoImv.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 85.0, height: 85.0))
            make.centerX.equalTo(self.view).offset(80.0)
            make.centerY.equalTo(appLogoImv)
        }
        welcomeLbl.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(appLogoImv.snp.bottom).offset(UIDevice.isLittleSize ? 70.0 : 90.0)
        }
        networkTipsLbl.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.bottom.equalTo(startDownloadBtn.snp.top).offset(-10.0)
        }
        startDownloadBtn.snp.makeConstraints { (make) in
            make.left.equalTo(25.0)
            make.right.equalTo(-25.0)
            make.bottom.equalTo(-(35.0 + Constant.UI.Size.bottomSafePadding))
            make.height.equalTo(44.0)
        }
        shipLoadView.snp.makeConstraints { (make) in
            make.left.equalTo(55.0)
            make.right.equalTo(-55.0)
            make.top.equalTo(appLogoImv.snp.bottom).offset(UIDevice.isLittleSize ? 70.0 : 90.0)
        }
        equipmentLoadView.snp.makeConstraints { (make) in
            make.left.right.equalTo(shipLoadView)
            make.top.equalTo(shipLoadView.snp.bottom).offset(UIDevice.isLittleSize ? 15.0 : 20.0)
        }
        areaLoadView.snp.makeConstraints { (make) in
            make.left.right.equalTo(shipLoadView)
            make.top.equalTo(equipmentLoadView.snp.bottom).offset(UIDevice.isLittleSize ? 15.0 : 20.0)
        }
        missionLoadView.snp.makeConstraints { (make) in
            make.left.right.equalTo(shipLoadView)
            make.top.equalTo(areaLoadView.snp.bottom).offset(UIDevice.isLittleSize ? 15.0 : 20.0)
        }
        expeditionLoadView.snp.makeConstraints { (make) in
            make.left.right.equalTo(shipLoadView)
            make.top.equalTo(missionLoadView.snp.bottom).offset(UIDevice.isLittleSize ? 15.0 : 20.0)
        }
        enemyLoadView.snp.makeConstraints { (make) in
            make.left.right.equalTo(shipLoadView)
            make.top.equalTo(expeditionLoadView.snp.bottom).offset(UIDevice.isLittleSize ? 15.0 : 20.0)
        }
        improveLoadView.snp.makeConstraints { (make) in
            make.left.right.equalTo(shipLoadView)
            make.top.equalTo(enemyLoadView.snp.bottom).offset(UIDevice.isLittleSize ? 15.0 : 20.0)
        }
        
        ///初始化数据库
        DBTool.initDatabase()
    }
    
    deinit {
        print("larry sue : \(#function)")
    }
    
    // MARK: *** 回调 ***
    
    @objc private func startDownloadBtnDidClick() {
        UIView.animate(withDuration: 0.3, animations: {
            self.welcomeLbl.transform = CGAffineTransform(translationX: 0, y: -20.0)
            self.welcomeLbl.alpha = 0.0
            self.networkTipsLbl.alpha = 0.0
            self.startDownloadBtn.alpha = 0.0
        }, completion: { (finish) in
            if finish {
                self.showLoadingText()
            }
        })
    }
    
    // MARK: *** 逻辑 ***
    
    ///展示分类加载文本
    private func showLoadingText() {
        
        let transform = CGAffineTransform(translationX: 0, y: 20.0)
        
        shipLoadView.transform = transform
        equipmentLoadView.transform = transform
        areaLoadView.transform = transform
        missionLoadView.transform = transform
        expeditionLoadView.transform = transform
        enemyLoadView.transform = transform
        improveLoadView.transform = transform
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.shipLoadView.transform = .identity
            self.shipLoadView.titleLbl.alpha = 1.0
            self.shipLoadView.loadDaisy.alpha = 1.0
        }, completion: { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.9, execute: {
                self.loadProcess += 1
                self.shipLoadView.dataInitCompleted = true
            })
        })
        UIView.animate(withDuration: 0.3, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.equipmentLoadView.transform = .identity
            self.equipmentLoadView.titleLbl.alpha = 1.0
            self.equipmentLoadView.loadDaisy.alpha = 1.0
        }, completion: { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
                self.loadProcess += 1
                self.equipmentLoadView.dataInitCompleted = true
            })
        })
        UIView.animate(withDuration: 0.3, delay: 0.4, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.areaLoadView.transform = .identity
            self.areaLoadView.titleLbl.alpha = 1.0
            self.areaLoadView.loadDaisy.alpha = 1.0
        }, completion: { (_) in
//            DataTool.initArea({ (error) in
//                if error != nil {
//                    print("larry sue : \(String(describing: error?.localizedDescription))")
//                } else {
//                    self.loadProcess += 1
//                    self.areaLoadView.dataInitCompleted = true
//                }
//            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
                self.loadProcess += 1
                self.areaLoadView.dataInitCompleted = true
            })
        })
        UIView.animate(withDuration: 0.3, delay: 0.6, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.missionLoadView.transform = .identity
            self.missionLoadView.titleLbl.alpha = 1.0
            self.missionLoadView.loadDaisy.alpha = 1.0
        }, completion: { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                self.loadProcess += 1
                self.missionLoadView.dataInitCompleted = true
            })
        })
        UIView.animate(withDuration: 0.3, delay: 0.8, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.expeditionLoadView.transform = .identity
            self.expeditionLoadView.titleLbl.alpha = 1.0
            self.expeditionLoadView.loadDaisy.alpha = 1.0
        }, completion: { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.loadProcess += 1
                self.expeditionLoadView.dataInitCompleted = true
            })
        })
        UIView.animate(withDuration: 0.3, delay: 1.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.enemyLoadView.transform = .identity
            self.enemyLoadView.titleLbl.alpha = 1.0
            self.enemyLoadView.loadDaisy.alpha = 1.0
        }, completion: { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                self.loadProcess += 1
                self.enemyLoadView.dataInitCompleted = true
            })
        })
        UIView.animate(withDuration: 0.3, delay: 1.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.improveLoadView.transform = .identity
            self.improveLoadView.titleLbl.alpha = 1.0
            self.improveLoadView.loadDaisy.alpha = 1.0
        }, completion: { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.loadProcess += 1
                self.improveLoadView.dataInitCompleted = true
            })
        })
    }
}

private class ATCategoryCheckView: UIView {
    
    // MARK: *** 属性 ***
    
    ///数据下载完成
    var dataInitCompleted: Bool = false {
        didSet {
            if dataInitCompleted {
                UIView.animate(withDuration: 0.1, animations: {
                    self.loadDaisy.alpha = 0.0
                }, completion: { (animaFinished) in
                    if animaFinished {
                        UIView.animate(withDuration: 0.1, animations: {
                            self.checkMarkImv.alpha = 1.0
                        })
                    }
                })
            }
        }
    }
    
    lazy var titleLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.title2
        label.textColor = Constant.UI.Color.theme
        label.textAlignment = .left
        label.alpha = 0.0
        
        return label
    }()
    lazy var loadDaisy: UIActivityIndicatorView = {
        let daisy = UIActivityIndicatorView()
        
        daisy.color = Constant.UI.Color.theme
        daisy.startAnimating()
        daisy.alpha = 0.0
        
        return daisy
    }()
    lazy var checkMarkImv: UIImageView = {
        var image = UIImage(named: "checkmark")
        image = image?.resizeImage(to: CGSize(width: 25.0, height: 25.0))
        image = image?.withRenderingMode(.alwaysTemplate)
        let imv = UIImageView(image: image)
        
        imv.tintColor = Constant.UI.Color.theme
        imv.alpha = 0.0
        
        return imv
    }()
    
    // MARK: *** 构造方法 ***
    
    convenience init(title: String) {
        self.init(frame: .zero)
        
        addSubview(titleLbl)
        addSubview(loadDaisy)
        addSubview(checkMarkImv)
        
        titleLbl.snp.makeConstraints { (make) in
            make.top.bottom.left.equalTo(0)
        }
        loadDaisy.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 30.0, height: 30.0))
            make.centerY.equalTo(self.titleLbl)
            make.right.equalTo(0)
        }
        checkMarkImv.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 25.0, height: 25.0))
            make.center.equalTo(self.loadDaisy)
        }
        
        titleLbl.text = title
    }
}
