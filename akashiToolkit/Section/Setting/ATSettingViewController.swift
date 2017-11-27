//
//  ATSettingViewController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/27.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit
import SDWebImage

class ATSettingViewController: ATViewController {
    
    private var settingModel = ATUserSettingModel.shared
    
    ///彩蛋
    private var clearCacheTimestamp: TimeInterval = Date().timeIntervalSince1970
    private var clearCacheCount: Int = 0
    
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
            let cell = ATTableViewDisclosureIndicatorWithLabelCell.forTableView(tableView as! ATTableView, at: indexPath)
            cell.textLabel?.text = "官推语言"
            cell.rightLabel.text = settingModel.twitterLanguage.toString()
            return cell
        } else {
            let cell = ATTableViewChrysanthemumWithLabelCell.forTableView(tableView as! ATTableView, at: indexPath)
            cell.textLabel?.text = "清理缓存"
            cell.rightLabel.text = NSString(format: "%.1fMB", Double(SDImageCache.shared().getSize()) / 1024.0 / 1024.0) as String
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
                vc.selectedLanguage = settingModel.twitterLanguage
                vc.delegate = self
                navigationController?.pushViewController(vc, animated: true)
            }
        } else if section == 1 {
            if row == 0 {
                let cacheManager = SDImageCache.shared()
                
                let imgCount = cacheManager.getDiskCount()
                let imgSize  = cacheManager.getSize()
                
                if imgSize == 0 {
                    let currentTimestamp = Date().timeIntervalSince1970
                    if clearCacheCount == 0 || currentTimestamp - clearCacheTimestamp > 2.5 {
                        ATToastMessageTool.show("没有缓存")
                        clearCacheTimestamp = currentTimestamp
                        clearCacheCount = 1;
                    } else {
                        if clearCacheCount == 1 {
                            ATToastMessageTool.show("真的没有缓存了 ╮(￣▽￣)╭")
                        } else if clearCacheCount == 2 {
                            ATToastMessageTool.show("所以说真的没有缓存啦 ⊙ˍ⊙")
                        } else if clearCacheCount == 3 {
                            ATToastMessageTool.show("哎呀不要点啦! ＞︿＜")
                        } else if clearCacheCount >= 4 {
                            ATToastMessageTool.show("别点啦! 别点啦! 别点啦! (>皿<)")
                        }
                        clearCacheTimestamp = currentTimestamp
                        clearCacheCount += 1
                    }
                } else {
                    let cell = tableView.cellForRow(at: indexPath) as! ATTableViewChrysanthemumWithLabelCell
                    cell.isRolling = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                        cacheManager.clearDisk(onCompletion: {
                            let mesg = NSString(format: "清理缓存图片: %zi张, 共%.1fMB", imgCount, Double(imgSize) / 1024.0 / 1024.0)
                            ATToastMessageTool.show(mesg as String)
                            cell.isRolling = false
                            self.listView.reloadRows(at: [self.listView.indexPath(for: cell)!], with: .none)
                        })
                    })
                }
            }
        }
    }
}

extension ATSettingViewController: ATSettingTwitterLanguageViewControllerDelegate {
    func settingTwitterLanguageViewController(_ viewController: ATSettingTwitterLanguageViewController, didSelected language: ATUserSetting.twitter.language) {
        settingModel.twitterLanguage = language
        
        listView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
}






