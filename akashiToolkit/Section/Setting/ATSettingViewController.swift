//
//  ATSettingViewController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/27.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

private let ATSettingViewControllerCellIdentifier = "ATSettingViewControllerCellIdentifier"

class ATSettingViewController: ATBaseViewController {
    
    private lazy var listView: UITableView = {
        let listView = UITableView(frame: .zero, style: .grouped)
        
        listView.dataSource = self
        listView.delegate = self
        
        return listView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(listView)
        
        listView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(navView.snp.bottom)
        }
        
        listView.register(UITableViewCell.self, forCellReuseIdentifier: ATSettingViewControllerCellIdentifier)
    }
}

extension ATSettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        }
        return 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "官推"
        } else if section == 1 {
            return "缓存"
        }
        return ""
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ATSettingViewControllerCellIdentifier, for: indexPath)
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            if row == 0 {
                cell.textLabel?.text = "官推语言"
                cell.accessoryType = .none
            }
        } else if section == 1 {
            if row == 0 {
                cell.textLabel?.text = "清理缓存"
                cell.accessoryType = .none
            }
        }
        
        return cell
    }
}

extension ATSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("larry sue : \(indexPath.section) - \(indexPath.row)")
    }
}






