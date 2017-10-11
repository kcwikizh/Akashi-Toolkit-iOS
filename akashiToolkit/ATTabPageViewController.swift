//
//  ATTabPageViewController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/12.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

@objc protocol ATTabPagerDataSource: NSObjectProtocol {
    func numberOfViewControllers() -> Int
    func viewController(for index: Int) -> UIViewController
    
    @objc optional func viewForTab(at index: Int) -> UIView
    @objc optional func titleForTab(at index: Int) -> String
    @objc optional func tabHeight() -> Float
    @objc optional func tabColor() -> UIColor
    @objc optional func tabBackgroundColor() -> UIColor
    @objc optional func titleFont() -> UIFont
    @objc optional func titleColor() -> UIColor
    @objc optional func bottomLineHeight() -> Float
}
@objc protocol ATTabPagerDelegate: NSObjectProtocol {
    @objc func tabPager(_ tabPager: ATTabPageViewController, willTransitionToTabAt index: Int)
    @objc func tabPager(_ tabPager: ATTabPageViewController, didTransitionToTabAt index: Int)
}

class ATTabPageViewController: UIViewController {
    
    var tabScrollDelegate: ATTabPagerDataSource?
    var delegate: ATTabPagerDelegate?

    func reloadData() {
        
    }
    func selected(at index: Int) {
        
    }
    
    func selectTabbar(at index: Int) {
        
    }
    func selectTabbar(at index: Int, animated: Bool) {
        
    }
}
