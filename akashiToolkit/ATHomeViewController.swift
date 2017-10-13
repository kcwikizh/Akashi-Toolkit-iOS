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
    
    override func viewDidLoad() {
        title = "ATHomeViewController"
        view.backgroundColor = .lightGray
        
        let pageTabView = LSPageTabView(type: .stationary, tabCount: 3)
        pageTabView.tabBarColor = .orange
        view.addSubview(pageTabView)
        
        pageTabView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
    }
}







