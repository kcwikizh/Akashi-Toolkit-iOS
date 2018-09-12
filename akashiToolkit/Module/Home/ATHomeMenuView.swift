//
//  ATHomeMenuView.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/25.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol ATHomeMenuViewDelegate {
    func homeMenuView(_ homeMenuView: ATHomeMenuView, didSelectItemAt index: Int)
}

private let ATHomeMenuViewCellIdentifier = "ATHomeMenuViewCellIdentifier"

class ATHomeMenuView: UIView {
    
    // MARK: *** 属性 ***
    
    var itemList: [HomeMenuItemModel] = [] {
        didSet {
            observableItemList = Observable.from(itemList)
        }
    }
    private var observableItemList: Observable<HomeMenuItemModel> = Observable.empty() {
        didSet {
            listView.reloadData()
        }
    }
    
    var delegate: ATHomeMenuViewDelegate?
    
    lazy var listView: ATTableView = {
        let tableView = ATTableView(frame: .zero, style: .grouped)
        
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.contentOffset = CGPoint(x: 0, y: UIScreen.height * 0.5)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private lazy var logoBtn: UIButton = {
        let button = UIButton(type: .custom)
        let icon = UIImage(named: "appLogo")?.resizeImage(to: CGSize(width: 75.0, height: 75.0))
        button.adjustsImageWhenHighlighted = false
        button.setImage(icon, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(didClickLogo), for: UIControl.Event.touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Constant.UI.Color.darkForeground
        
        addSubview(listView)
        addSubview(logoBtn)
        
        logoBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 75.0, height: 75.0))
            make.centerX.equalTo(self)
            
            var top = 75
            if UIDevice.isFuckedX {
                top = 140
            } else if UIDevice.isLargeSize {
                top = 100
            } else if UIDevice.isLittleSize {
                top = 80
            }
            
            make.top.equalTo(top)
        }
        listView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            
            var topOffset = 40
            if UIDevice.isFuckedX {
                topOffset = 80
            } else if UIDevice.isLargeSize {
                topOffset = 60
            } else if UIDevice.isLittleSize {
                topOffset = 30
            }
            
            make.top.equalTo(logoBtn.snp.bottom).offset(topOffset)
        }
        
        listView.register(ATHomeMenuViewCell.self, forCellReuseIdentifier: ATHomeMenuViewCellIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didClickLogo() {
        ///logo缩放
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        
        scaleAnimation.values = [1.0, 2.0]
        scaleAnimation.keyTimes = [0, 1]
        scaleAnimation.timingFunctions = [CAMediaTimingFunction(name: .easeOut)]
        scaleAnimation.calculationMode = .linear
        
        ///logo移动
        let xAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        
        xAnimation.values = [0, UIScreen.width * 0.5 - logoBtn.center.x]
        xAnimation.keyTimes = [0, 1]
        xAnimation.timingFunctions = [CAMediaTimingFunction(name: .easeOut)]
        xAnimation.calculationMode = .linear
        
        let yAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        
        yAnimation.values = [0, Constant.UI.Size.topHeight + 40.0 + 150.0 * 0.5 - logoBtn.center.y]
        yAnimation.keyTimes = [0, 1]
        yAnimation.timingFunctions = [CAMediaTimingFunction(name: .easeOut)]
        yAnimation.calculationMode = .linear
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [scaleAnimation, xAnimation, yAnimation]
        animationGroup.duration = 0.3
        animationGroup.fillMode = .forwards
        animationGroup.isRemovedOnCompletion = false
        
        logoBtn.layer.add(animationGroup, forKey: "anima.logo.group")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.delegate?.homeMenuView(self, didSelectItemAt: self.itemList.count - 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.logoBtn.layer.removeAllAnimations()
            }
        }
    }
}

extension ATHomeMenuView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count - 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ATHomeMenuViewCellIdentifier, for: indexPath) as! ATHomeMenuViewCell
        
        cell.icon = itemList[indexPath.row].icon
        cell.title = itemList[indexPath.row].title
        
        return cell
    }
}


extension ATHomeMenuView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.homeMenuView(self, didSelectItemAt: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.isLittleSize ? 35.0 : 45.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.height * 0.5
    }
}


private class ATHomeMenuViewCell: UITableViewCell {
    
    var icon: UIImage? {
        didSet {
            iconView.image = icon?.withRenderingMode(.alwaysTemplate)
        }
    }
    var title: String? {
        didSet {
            titleLbl.text = title
        }
    }
    
    private lazy var iconView: UIImageView = {
        let imv = UIImageView()
        
        imv.tintColor = .gray
        
        return imv
    }()
    private lazy var titleLbl: UILabel = {
        let label = UILabel()
        
        label.font = .callout
        label.textColor = .gray
        label.textAlignment = .left
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(iconView)
        contentView.addSubview(titleLbl)
        
        iconView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 20.0, height: 20.0))
            make.right.equalTo(-10.0)
            make.centerY.equalTo(self.contentView)
        }
        titleLbl.snp.makeConstraints { (make) in
            make.right.equalTo(iconView.snp.left).offset(5.0)
            make.left.equalTo(10.0)
            make.centerY.equalTo(iconView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
