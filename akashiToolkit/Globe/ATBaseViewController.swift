//
//  ATBaseViewController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/24.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit
import SnapKit

class ATBaseViewController: UIViewController {
    
    /// MARK: *** 属性 ***
    
    ///导航栏
    lazy var navView: UIView = {
        let view = UIView()
        
        view.backgroundColor = Constant.ui.color.navigationBar
        
        return view
    }()
    lazy var titleLbl: UILabel = {
        let label = UILabel()
        
        label.font = .headline
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    ///返回按钮
    private lazy var backBtn: UIButton = {
        let button = UIButton(type: .custom)
        
        button.addTarget(self, action: #selector(backBtnDidClick), for: .touchUpInside)
        
        return button
    }()
    ///右侧按钮
    private lazy var rightBtn: UIButton = {
        let button = UIButton(type: .custom)
        
        button.addTarget(self, action: #selector(rightBtnDidClick), for: .touchUpInside)
        button.backgroundColor = .brown
        
        return button
    }()
    
    ///是否显示返回按钮
    var showBackBtn: Bool = true {
        didSet {
            backBtn.isHidden = !showBackBtn
        }
    }
    ///是否显示右侧按钮
    var showRightBtn: Bool = true {
        didSet {
            rightBtn.isHidden = !showRightBtn
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Constant.ui.color.darkPageBackground
        
        view.addSubview(navView)
        navView.addSubview(backBtn)
        navView.addSubview(rightBtn)
        navView.addSubview(titleLbl)
        
        navView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(Constant.ui.size.topHeight)
        }
        backBtn.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(0)
            make.top.equalTo(Constant.ui.size.statusBarHeight)
            make.width.equalTo(55.0)
        }
        rightBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(0)
            make.top.equalTo(Constant.ui.size.statusBarHeight)
            make.width.equalTo(55.0)
        }
        titleLbl.snp.makeConstraints { (make) in
            make.top.equalTo(Constant.ui.size.statusBarHeight)
            make.bottom.equalTo(0)
            make.left.equalTo(backBtn.snp.right)
            make.right.equalTo(rightBtn.snp.left)
        }
    }
    
    /// MARK: *** 回调 ***
    @objc func backBtnDidClick() {
        navigationController?.popViewController(animated: true)
    }
    @objc func rightBtnDidClick() {
        
    }
}
