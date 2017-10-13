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
        
        navigationBar.barTintColor = .brown
        
        let navBar = UINavigationBar.appearance()
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true;
    }
}
