//
//  BaseNavigationController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/9.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar = UINavigationBar.appearance()
        navBar.isHidden = true
    }
    
    ///状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
