//
//  ATAboutViewController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/27.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit
import MessageUI

class ATAboutViewController: ATViewController {
    
    private lazy var listView: ATTableView = {
        let listView = ATTableView(frame: .zero, style: .grouped)
        
        listView.tableHeaderView = self.headerView
        listView.dataSource = self
        listView.delegate = self
        
        return listView
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: 320))
        
        view.backgroundColor = .clear
        
        view.addSubview(appLogoImv)
        view.addSubview(versionLbl)
        view.addSubview(copyrightTipsLbl)
        view.addSubview(organizationLogoImv)
        
        appLogoImv.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: 150.0, height: 150.0))
            make.centerX.equalTo(view)
            make.top.equalTo(40.0)
        })
        versionLbl.snp.makeConstraints({ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(appLogoImv.snp.bottom).offset(25.0)
        })
        copyrightTipsLbl.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: 227.0, height: 22.0))
            make.centerX.equalTo(view).offset(-22.5)
            make.top.equalTo(versionLbl.snp.bottom).offset(35.0)
        })
        organizationLogoImv.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: 35.0, height: 35.0))
            make.centerY.equalTo(copyrightTipsLbl)
            make.left.equalTo(copyrightTipsLbl.snp.right).offset(10.0)
        })
        
        return view
    }()
    
    private lazy var appLogoImv: UIImageView = UIImageView(image: UIImage(named: "appLogo")?.resizeImage(to: CGSize(width: 150.0, height: 150.0)))
    private lazy var organizationLogoImv: UIImageView = UIImageView(image: UIImage(named: "organizationLogo")?.resizeImage(to: CGSize(width: 35.0, height: 35.0)))
    private lazy var versionLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.body
        label.textColor = Constant.ui.color.auxiliaryText
        label.textAlignment = .center
        label.text = "Ver : \(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)"
        
        return label
    }()
    private lazy var copyrightTipsLbl: UITextView = {
        let label = UITextView()
        
        label.font = UIFont.footnote
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.isEditable = false
        label.isSelectable = true
        label.isScrollEnabled = false
        label.showsVerticalScrollIndicator = false
        label.delegate = self
        let str = "本APP数据均由 舰娘百科 / kcwiki 提供"
        let attStr = NSMutableAttributedString(string: str)
        attStr.addAttribute(.link, value: Constant.official.website, range: (str as NSString).range(of: "舰娘百科 / kcwiki"))
        label.attributedText = attStr
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(listView)
        
        listView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(navView.snp.bottom)
        }
    }
    
    private func sendMail(to address: URL) {
        
    }
}

extension ATAboutViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 1
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            if row == 0 {
                let cell = ATTableViewDisclosureIndicatorCell.forTableView(tableView as! ATTableView, at: indexPath)
                cell.textLabel?.text = "官方微博"
                return cell
            } else {
                let cell = ATTableViewDisclosureIndicatorCell.forTableView(tableView as! ATTableView, at: indexPath)
                cell.textLabel?.text = "微信公众号"
                return cell
            }
        } else {
            let cell = ATTableViewDisclosureIndicatorCell.forTableView(tableView as! ATTableView, at: indexPath)
            cell.textLabel?.text = "意见反馈"
            return cell
        }
    }
}

extension ATAboutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            if row == 0 {
                if UIApplication.shared.canOpenURL(Constant.official.weibo) {
                    UIApplication.shared.openURL(Constant.official.weibo)
                }
            } else {
                
            }
        } else {
            let alert = UIAlertController(title: "反馈", message: "请根据您遇到的问题类型选择", preferredStyle: .alert)
            
            let dataQuestion = UIAlertAction(title: "数据问题: 联系编辑组", style: .default, handler: { (action) in
                if UIApplication.shared.canOpenURL(Constant.official.dataFeedback) {
                    UIApplication.shared.openURL(Constant.official.dataFeedback)
                }
            })
            let appQuestion = UIAlertAction(title: "软件问题: 联系开发者", style: .default, handler: { (action) in
                
            })
            let cancel = UIAlertAction(title: "取消", style: .default)
            
            alert.addAction(dataQuestion)
            alert.addAction(appQuestion)
            alert.addAction(cancel)
            
            present(alert, animated: true)
        }
    }
}

extension ATAboutViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        return true
    }
}
