//
//  ATSettingViewController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/27.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

class ATSettingViewController: ATViewController {
    
    private var settingModel = ATUserSettingModel.default
    
    private lazy var listView: ATTableView = {
        let listView = ATTableView(frame: .zero, style: .grouped)
        
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
        let section = indexPath.section
        
        if section == 0 {
            let cell = ATTableViewDisclosureIndicatorCell.forTableView(tableView as! ATTableView, at: indexPath)
            cell.textLabel?.text = "官推语言"
            return cell
        } else {
            let cell = ATTableViewNoneCell.forTableView(tableView as! ATTableView, at: indexPath)
            cell.textLabel?.text = "清理缓存"
            return cell
        }
    }
}

extension ATSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            if row == 0 {
                let vc = ATSettingTwitterLanguageViewController()
                vc.selectedLanguage = .jp
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}






