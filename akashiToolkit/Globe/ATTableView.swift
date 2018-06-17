//
//  ATTableView.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/11/9.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

private let ATTableViewNoneCellIdentifier = "ATTableViewNoneCellIdentifier"
private let ATTableViewChrysanthemumCellIdentifier = "ATTableViewChrysanthemumCellIdentifier"
private let ATTableViewChrysanthemumWithLabelCellIdentifier = "ATTableViewChrysanthemumWithLabelCellIdentifier"
private let ATTableViewDisclosureIndicatorCellIdentifier = "ATTableViewDisclosureIndicatorCellIdentifier"
private let ATTableViewDisclosureIndicatorWithLabelCellIdentifier = "ATTableViewDisclosureIndicatorWithLabelCellIdentifier"
private let ATTableViewCheckmarkCellIdentifier = "ATTableViewCheckmarkCellIdentifier"

class ATTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        backgroundColor = Constant.ui.color.lightBackground
        
        if #available(iOS 11.0, *) {
            estimatedRowHeight = 0
            estimatedSectionFooterHeight = 0
            estimatedSectionHeaderHeight = 0
            insetsContentViewsToSafeArea = false
        }
        
        register(ATTableViewNoneCell.self, forCellReuseIdentifier: ATTableViewNoneCellIdentifier)
        register(ATTableViewChrysanthemumCell.self, forCellReuseIdentifier: ATTableViewChrysanthemumCellIdentifier)
        register(ATTableViewChrysanthemumWithLabelCell.self, forCellReuseIdentifier: ATTableViewChrysanthemumWithLabelCellIdentifier)
        register(ATTableViewDisclosureIndicatorCell.self, forCellReuseIdentifier: ATTableViewDisclosureIndicatorCellIdentifier)
        register(ATTableViewDisclosureIndicatorWithLabelCell.self, forCellReuseIdentifier: ATTableViewDisclosureIndicatorWithLabelCellIdentifier)
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
        cell.textLabel?.textColor = Constant.ui.color.majorText
        
        return cell
    }
}

///原生空cell
class ATTableViewNoneCell: ATTableViewCell {
    class func forTableView(_ tableView: ATTableView, at indexPath: IndexPath) -> ATTableViewNoneCell {
        let cell = cellForTableView(tableView, at: indexPath, identifier: ATTableViewNoneCellIdentifier) as! ATTableViewNoneCell
        
        cell.accessoryType = .none
        
        return cell
    }
}

///右侧菊花cell
class ATTableViewChrysanthemumCell: ATTableViewNoneCell {
    
    var isRolling: Bool = false {
        didSet {
            if isRolling {
                self.chrysanthemum.startAnimating()
            } else {
                self.chrysanthemum.stopAnimating()
            }
        }
    }
    
    fileprivate lazy var chrysanthemum: UIActivityIndicatorView = {
        let crs = UIActivityIndicatorView()
        
        crs.color = Constant.ui.color.auxiliaryText
        
        self.contentView.addSubview(crs)
        
        crs.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-15.0)
        })
        
        return crs
    }()
    
    override class func forTableView(_ tableView: ATTableView, at indexPath: IndexPath) -> ATTableViewChrysanthemumCell {
        let cell = cellForTableView(tableView, at: indexPath, identifier: ATTableViewChrysanthemumCellIdentifier) as! ATTableViewChrysanthemumCell
        
        cell.accessoryType = .none
        
        return cell
    }
}

///右侧菊花带文本cell
class ATTableViewChrysanthemumWithLabelCell: ATTableViewChrysanthemumCell {
    
    override var isRolling: Bool {
        didSet {
            if isRolling {
                self.rightLabel.isHidden = true
            } else {
                self.rightLabel.isHidden = false
            }
        }
    }
    
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.subheadline
        label.textAlignment = .right
        label.textColor = Constant.ui.color.auxiliaryText
        
        self.contentView.addSubview(label)
        
        label.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-15.0)
        })
        
        return label
    }()
    
    override class func forTableView(_ tableView: ATTableView, at indexPath: IndexPath) -> ATTableViewChrysanthemumWithLabelCell {
        let cell = cellForTableView(tableView, at: indexPath, identifier: ATTableViewChrysanthemumWithLabelCellIdentifier) as! ATTableViewChrysanthemumWithLabelCell
        
        cell.accessoryType = .none
        
        return cell
    }
}

///原生箭头cell
class ATTableViewDisclosureIndicatorCell: ATTableViewCell {
    class func forTableView(_ tableView: ATTableView, at indexPath: IndexPath) -> ATTableViewDisclosureIndicatorCell {
        let cell = cellForTableView(tableView, at: indexPath, identifier: ATTableViewDisclosureIndicatorCellIdentifier) as! ATTableViewDisclosureIndicatorCell
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

///原生箭头带右侧文字标签cell
class ATTableViewDisclosureIndicatorWithLabelCell: ATTableViewDisclosureIndicatorCell {
    
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.subheadline
        label.textAlignment = .right
        label.textColor = Constant.ui.color.auxiliaryText
        
        self.contentView.addSubview(label)
        
        label.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.contentView).offset(-1.0)
            make.right.equalTo(self.textLabel!)
        })
        
        return label
    }()
    
    override class func forTableView(_ tableView: ATTableView, at indexPath: IndexPath) -> ATTableViewDisclosureIndicatorWithLabelCell {
        let cell = cellForTableView(tableView, at: indexPath, identifier: ATTableViewDisclosureIndicatorWithLabelCellIdentifier) as! ATTableViewDisclosureIndicatorWithLabelCell
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

///原生对勾cell
class ATTableViewCheckmarkCell: ATTableViewCell {
    class func forTableView(_ tableView: ATTableView, at indexPath: IndexPath) -> ATTableViewCheckmarkCell {
        let cell = cellForTableView(tableView, at: indexPath, identifier: ATTableViewCheckmarkCellIdentifier) as! ATTableViewCheckmarkCell
        
        cell.accessoryType = .checkmark
        
        return cell
    }
}

