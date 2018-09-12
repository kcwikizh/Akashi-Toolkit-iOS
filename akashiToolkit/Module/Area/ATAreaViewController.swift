//
//  ATAreaViewController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/27.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

class ATAreaViewController: BaseViewController {
    
    // MARK: *** 属性 ***
    
    private lazy var pageTabView: LSPageTabView = {
        let view = LSPageTabView(type: .stationary)
        
        view.tabBarColor = Constant.UI.Color.theme
        view.sliderColor = Constant.UI.Color.lightForeground
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    // MARK: *** 周期 ***
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ATAreaViewController: LSPageTabViewDataSource {
    func numberOfTab(in pageTabView: LSPageTabView) -> Int {
        return 4
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
    
    
}

extension ATAreaViewController: LSPageTabViewDelegate {
    
}
