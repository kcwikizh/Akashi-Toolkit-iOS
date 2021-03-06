//
//  BaseViewController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/24.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    /// MARK: *** 属性 ***
    
    private let disposeBag = DisposeBag()
    
    var leftSubscribe: Disposable? = nil
    var rightSubscribe: Disposable? = nil
    
    ///导航栏
    lazy var navView: UIView = {
        let view = UIView()
        
        view.backgroundColor = Constant.UI.Color.theme
        
        return view
    }()
    ///标题栏
    lazy var titleLbl: UILabel = {
        let label = UILabel()
        
        label.font = .headline
        label.textColor = Constant.UI.Color.lightForeground
        label.textAlignment = .center
        
        return label
    }()
    ///返回按钮
    lazy var leftBtn: UIButton = {
        let button = UIButton(type: .custom)
        
        leftSubscribe = button.rx.tap.subscribe(onNext: { [unowned self] in
            self.navigationController?.popViewController(animated: true)
        })
        leftSubscribe?.disposed(by: disposeBag)
        
        let image = UIImage(named: "back")?.resizeImage(to: CGSize(width: 20.0, height: 20.0)).withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .center
        button.tintColor = Constant.UI.Color.lightForeground
        button.adjustsImageWhenHighlighted = false
        
        return button
    }()
    ///右侧按钮
    lazy var rightBtn: UIButton = {
        let button = UIButton(type: .custom)
        
        rightSubscribe = button.rx.tap.subscribe(onNext: { [unowned self] in
            
        })
        rightSubscribe?.disposed(by: disposeBag)
        
        button.tintColor = Constant.UI.Color.lightForeground
        button.adjustsImageWhenHighlighted = false
        
        return button
    }()
    
    override var title: String? {
        didSet {
            titleLbl.text = title
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Constant.UI.Color.lightBackground
        
        view.addSubview(navView)
        navView.addSubview(leftBtn)
        navView.addSubview(rightBtn)
        navView.addSubview(titleLbl)
        
        navView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(Constant.UI.Size.topHeight)
        }
        leftBtn.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(0)
            make.top.equalTo(Constant.UI.Size.statusBarHeight)
            make.width.equalTo(55.0)
        }
        rightBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(0)
            make.top.equalTo(Constant.UI.Size.statusBarHeight)
            make.width.equalTo(55.0)
        }
        titleLbl.snp.makeConstraints { (make) in
            make.top.equalTo(Constant.UI.Size.statusBarHeight)
            make.bottom.equalTo(0)
            make.left.equalTo(leftBtn.snp.right)
            make.right.equalTo(rightBtn.snp.left)
        }
    }
}
