//
//  LSPageTabView.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/13.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

public enum LSPageTabViewType: Int {
    case stationary
    case scrollable
}

class LSPageTabView: UIView {
    
    // MARK: *** 属性 ***
    
    ///标签栏
    private var tabBar: UIView = UIView()
    ///标签组
    private var tabs: [UIButton] = []
    ///标签栏高度
    public var tabBarHeight: CGFloat = 35
    ///标签栏底色
    public var tabBarColor: UIColor = UIColor.darkGray {
        didSet {
            tabBar.backgroundColor = tabBarColor
        }
    }
    
    ///滑块
    private var slider: UIView = UIView()
    public var sliderHeight: CGFloat = 5
    ///滑块色彩
    public var sliderColor: UIColor = UIColor.orange {
        didSet {
            slider.backgroundColor = sliderColor
        }
    }
    ///滑块是否显示
    public var showSlider: Bool = true {
        didSet {
            slider.isHidden = !showSlider
        }
    }
    
    ///当前所选索引
    private var selectedIndex: Int = 0
    
    private var type: LSPageTabViewType = .stationary
    
    // MARK: *** 构造方法 ***
    
    convenience init(type: LSPageTabViewType, tabCount: Int) {
        self.init()
        
        self.type = type
        
        addSubview(tabBar)
        
        for i in 0 ..< tabCount {
            let tab = UIButton(type: .custom)
            tab.tag = i
            tab.addTarget(self, action: #selector(tapOnTabBtn), for: .touchUpInside)
            tab.backgroundColor = UIColor.random()
            tabs.append(tab)
            tabBar.addSubview(tab)
        }
        tabBar.addSubview(slider)
    }
    
    // MARK: *** 布局 ***
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tabBar.frame.origin = CGPoint(x: 0, y: 0)
        tabBar.frame.size = CGSize(width: self.frame.width, height: tabBarHeight)
        
        let tabWidth = self.frame.width / CGFloat(tabs.count)
        for (idx, tab) in tabs.enumerated() {
            tab.frame = CGRect(x: CGFloat(idx) * tabWidth, y: 0, width: tabWidth, height: tabBarHeight)
        }
        slider.frame = CGRect(x: CGFloat(selectedIndex) * tabWidth, y: self.frame.height - sliderHeight, width: tabWidth, height: sliderHeight)
    }
    // MARK: *** 回调 ***
    
    @objc private func tapOnTabBtn(sender: UIButton) {
        print("larry sue : \(sender.tag)")
    }
}














