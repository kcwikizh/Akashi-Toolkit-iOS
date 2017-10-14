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
        let view = LSPageTabView(type: .stationary)
        
        view.dataSource = self
        
        return view
    }()
    
    override func viewDidLoad() {
        title = "ATHomeViewController"
        view.backgroundColor = .blue
        
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

extension ATHomeViewController: LSPageTabViewDatasource {
    func numberOfTab(in pageTabView: LSPageTabView) -> Int {
        return 3
    }
    
    func pageTabView(_ pageTabView: LSPageTabView, childViewAt index: Int) -> UIView {
        let view = UIView()
        
        if index == 0 {
            view.backgroundColor = .orange
        } else if index == 1 {
            view.backgroundColor = .brown
        } else {
            view.backgroundColor = .lightGray
        }
        
        return view
    }
}







