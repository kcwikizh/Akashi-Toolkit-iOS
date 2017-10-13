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
    
    private lazy var pageTabView: LSPageTabView = {
        let view = LSPageTabView(type: .stationary, tabCount: 3)
        
        return view
    }()
    
    override func viewDidLoad() {
        title = "ATHomeViewController"
        view.backgroundColor = .lightGray
        
        view.addSubview(pageTabView)
        
        pageTabView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(UITopHeight)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pageTabView.selectedTab(at: 1, animated: false)
    }
}







