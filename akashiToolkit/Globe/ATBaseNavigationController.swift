//
//  ATBaseNavigationController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/9.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

class ATBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = Constant.ui.color.navigationBar
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let navBar = UINavigationBar.appearance()
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = false;
    }
}
