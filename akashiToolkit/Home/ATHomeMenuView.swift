//
//  ATHomeMenuView.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/25.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

protocol ATHomeMenuViewDelegate {
    func homeMenuView(_ homeMenuView: ATHomeMenuView, didSelectItemAt index: Int)
}

private let ATHomeMenuViewCellIdentifier = "ATHomeMenuViewCellIdentifier"

class ATHomeMenuView: UIView {
    
    var itemList: [ATHomeMenuItemModel] = [] {
        didSet {
            listView.reloadData()
        }
    }
    
    var delegate: ATHomeMenuViewDelegate?
    
    lazy var listView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.contentOffset = CGPoint(x: 0, y: UIScreen.height * 0.5)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Constant.ui.color.darkForeground
        
        let logoView = UIImageView(image: UIImage(named: "appLogo"))
        
        addSubview(logoView)
        addSubview(listView)
        
        logoView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 75.0, height: 75.0))
            make.centerX.equalTo(self)
            
            var top = 65
            if UIDevice.isFuckedX {
                top = 120
            } else if UIDevice.isLargeSize {
                top = 100
            } else if UIDevice.isLittleSize {
                top = 50
            }
            
            make.top.equalTo(top)
        }
        listView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            
            var topOffset = 40
            if UIDevice.isFuckedX {
                topOffset = 80
            } else if UIDevice.isLargeSize {
                topOffset = 60
            } else if UIDevice.isLittleSize {
                topOffset = 20
            }
            
            make.top.equalTo(logoView.snp.bottom).offset(topOffset)
        }
        
        listView.register(ATHomeMenuViewCell.self, forCellReuseIdentifier: ATHomeMenuViewCellIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ATHomeMenuView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ATHomeMenuViewCellIdentifier, for: indexPath) as! ATHomeMenuViewCell
        
        cell.icon = itemList[indexPath.row].icon
        cell.title = itemList[indexPath.row].title
        
        return cell
    }
}


extension ATHomeMenuView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.homeMenuView(self, didSelectItemAt: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.isLittleSize ? 35.0 : 45.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.height * 0.5
    }
}


private class ATHomeMenuViewCell: UITableViewCell {
    
    var icon: UIImage? {
        didSet {
            iconView.image = icon?.withRenderingMode(.alwaysTemplate)
        }
    }
    var title: String? {
        didSet {
            titleLbl.text = title
        }
    }
    
    private lazy var iconView: UIImageView = {
        let imv = UIImageView()
        
        imv.tintColor = .gray
        
        return imv
    }()
    private lazy var titleLbl: UILabel = {
        let label = UILabel()
        
        label.font = .callout
        label.textColor = .gray
        label.textAlignment = .left
        
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(iconView)
        contentView.addSubview(titleLbl)
        
        iconView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 20.0, height: 20.0))
            make.right.equalTo(-10.0)
            make.centerY.equalTo(self.contentView)
        }
        titleLbl.snp.makeConstraints { (make) in
            make.right.equalTo(iconView.snp.left).offset(5.0)
            make.left.equalTo(10.0)
            make.centerY.equalTo(iconView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



