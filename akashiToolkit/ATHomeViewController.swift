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
        
        let tableview = UITableView(frame: .zero, style: .plain)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "testCell")
        tableview.dataSource = self
        tableview.delegate = self
        view.addSubview(tableview)
        
        tableview.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
    }
}

extension ATHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
}

extension ATHomeViewController: UITableViewDelegate {
    
}
