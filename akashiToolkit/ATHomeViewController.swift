//
//  ATHomeViewController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/9.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

class ATHomeViewController: UIViewController {
    
    override func viewDidLoad() {
        title = "ATHomeViewController"
        view.backgroundColor = .lightGray
        
        let hwLbl = UILabel(frame: view.bounds)
        hwLbl.font = UIFont.boldSystemFont(ofSize: 30.0)
        hwLbl.textAlignment = .center
        hwLbl.text = "Hello World !"
    }
}
