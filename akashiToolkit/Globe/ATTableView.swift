//
//  ATTableView.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/11/9.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

private let ATTableViewNoneCellIdentifier = "ATTableViewNoneCellIdentifier"
private let ATTableViewDisclosureIndicatorCellIdentifier = "ATTableViewDisclosureIndicatorCellIdentifier"
private let ATTableViewCheckmarkCellIdentifier = "ATTableViewCheckmarkCellIdentifier"

class ATTableView: UITableView {
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        backgroundColor = Constant.ui.color.lightBackground
        
        estimatedRowHeight = 0
        estimatedSectionFooterHeight = 0
        estimatedSectionHeaderHeight = 0
        
        if #available(iOS 11.0, *) {
            insetsContentViewsToSafeArea = false
        }
        
        register(ATTableViewNoneCell.self, forCellReuseIdentifier: ATTableViewNoneCellIdentifier)
        register(ATTableViewDisclosureIndicatorCell.self, forCellReuseIdentifier: ATTableViewDisclosureIndicatorCellIdentifier)
        register(ATTableViewCheckmarkCell.self, forCellReuseIdentifier: ATTableViewCheckmarkCellIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

///原生cell
class ATTableViewCell: UITableViewCell {
    fileprivate class func cellForTableView(_ tableView: ATTableView, at indexPath: IndexPath, identifier: String) -> ATTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ATTableViewCell
        
        cell.tintColor = Constant.ui.color.theme
        
        return cell
    }
}

///原生空cell
class ATTableViewNoneCell: ATTableViewCell {
    class func forTableView(_ tableView: ATTableView, at indexPath: IndexPath) -> ATTableViewCell {
        let cell = cellForTableView(tableView, at: indexPath, identifier: ATTableViewNoneCellIdentifier) as! ATTableViewNoneCell
        
        cell.accessoryType = .none
        
        return cell
    }
}

///原生箭头cell
class ATTableViewDisclosureIndicatorCell: ATTableViewCell {
    class func forTableView(_ tableView: ATTableView, at indexPath: IndexPath) -> ATTableViewCell {
        let cell = cellForTableView(tableView, at: indexPath, identifier: ATTableViewDisclosureIndicatorCellIdentifier) as! ATTableViewDisclosureIndicatorCell
        
        cell.accessoryType = .disclosureIndicator
        cell.accessoryView?.tintColor = Constant.ui.color.theme
        
        return cell
    }
}

///原生对勾cell
class ATTableViewCheckmarkCell: ATTableViewCell {
    class func forTableView(_ tableView: ATTableView, at indexPath: IndexPath) -> ATTableViewCell {
        let cell = cellForTableView(tableView, at: indexPath, identifier: ATTableViewCheckmarkCellIdentifier) as! ATTableViewCheckmarkCell
        
        cell.accessoryType = .checkmark
        
        return cell
    }
}

