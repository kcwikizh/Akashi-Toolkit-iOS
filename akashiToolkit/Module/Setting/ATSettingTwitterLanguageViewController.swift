////
////  ATSettingTwitterLanguageViewController.swift
////  akashiToolkit
////
////  Created by LarrySue on 2017/11/9.
////  Copyright © 2017年 kcwikizh. All rights reserved.
////
//
//import UIKit
//
//protocol ATSettingTwitterLanguageViewControllerDelegate {
//    func settingTwitterLanguageViewControllerDidSelectedLanguage(_ viewController: ATSettingTwitterLanguageViewController) -> Void
//}
//
//class ATSettingTwitterLanguageViewController: BaseViewController {
//    
//    var selectedLanguage: UserSetting.Twitter.language = .zh {
//        didSet {
//            listView.reloadData()
//        }
//    }
//    
//    var delegate: ATSettingTwitterLanguageViewControllerDelegate?
//    
//    private let list = UserSetting.Twitter.language.list
//    
//    private lazy var listView: ATTableView = {
//        let listView = ATTableView(frame: .zero, style: .grouped)
//        
//        listView.dataSource = self
//        listView.delegate = self
//        
//        return listView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.addSubview(listView)
//        title = "官推语言"
//        
//        listView.snp.makeConstraints { (make) in
//            make.left.right.bottom.equalTo(0)
//            make.top.equalTo(navView.snp.bottom)
//        }
//    }
//}
//
//extension ATSettingTwitterLanguageViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return list.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let row = indexPath.row
//        if row == selectedLanguage.rawValue {
//            let cell = ATTableViewCheckmarkCell.forTableView(tableView as! ATTableView, at: indexPath)
//            cell.textLabel?.text = list[row].toString()
//            return cell
//        } else {
//            let cell = ATTableViewNoneCell.forTableView(tableView as! ATTableView, at: indexPath)
//            cell.textLabel?.text = list[row].toString()
//            return cell
//        }
//    }
//}
//
//extension ATSettingTwitterLanguageViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//        selectedLanguage = list[indexPath.row]
//        UserSettingTool.setTwitterLanguage(selectedLanguage)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
//            self.navigationController?.popViewController(animated: true)
//            self.delegate?.settingTwitterLanguageViewControllerDidSelectedLanguage(self)
//        })
//    }
//}
