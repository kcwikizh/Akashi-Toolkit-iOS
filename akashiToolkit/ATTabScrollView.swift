//
//  ATTabScrollView.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/12.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

protocol ATTabScrollDelegate: UIScrollViewDelegate {
    func tabScrollView(_ tabScrollView: ATTabScrollView, didSelectTabAt index: Int)
}

class ATTabScrollView: UIScrollView {
    
    convenience init(frame: CGRect, tableViews: [UITableView], color: UIColor, bottomLineHeight: Float) {
        self.init(frame: frame)
    }
    convenience init(frame: CGRect, tableViews: [UITableView], color: UIColor, bottomLineHeight: Float, selectedTabIndex: Int) {
        self.init(frame: frame)
    }
    
    func selectTab(at index: Int) {
        
    }
    func selectTab(at index: Int, animated: Bool) {
        
    }
}
