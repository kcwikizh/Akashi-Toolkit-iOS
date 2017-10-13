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
    
    ///当前类型 固定/可滚动
    private var type: LSPageTabViewType = .stationary
    
    ///切换动画时长
    private let animationDuration = 0.5
    
    ///标签栏
    private lazy var tabBar: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.masksToBounds = true
        return view
    }()
    ///标签组
    private var tabs: [UIButton] = []
    ///标签栏高度
    public var tabBarHeight: CGFloat = 35
    ///标签栏底色
    public var tabBarColor: UIColor? {
        didSet {
            tabBar.backgroundColor = tabBarColor
        }
    }
    
    ///滑块
    private lazy var slider: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.layer.cornerRadius = self.sliderCornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    ///滑块高度(可见部分
    public var sliderVisibleHeight: CGFloat = 3 {
        didSet {
            sliderRealHeight = sliderVisibleHeight * 2
            sliderCornerRadius = sliderVisibleHeight * 0.5
        }
    }
    ///滑块高度(实际部分
    private var sliderRealHeight: CGFloat = 6
    ///滑块圆角
    private var sliderCornerRadius: CGFloat = 1.5 {
        didSet {
            slider.layer.cornerRadius = sliderCornerRadius
        }
    }
    ///滑块色彩
    public var sliderColor: UIColor? {
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
        slider.frame = CGRect(x: CGFloat(selectedIndex) * tabWidth, y: tabBar.frame.height - sliderVisibleHeight, width: tabWidth, height: sliderRealHeight)
    }
    // MARK: *** 回调 ***
    
    @objc private func tapOnTabBtn(sender: UIButton) {
        let targetIndex = sender.tag
        if targetIndex == selectedIndex {
            return
        }
        
        selectedTab(at: targetIndex, animated: true)
    }
    
    // MARK: *** 逻辑 ***
    
    public func selectedTab(at index: Int, animated: Bool) {
        selectedIndex = index
        moveSlider(animated: animated)
    }
    ///移动滑块
    private func moveSlider(animated: Bool) {
        var duration = TimeInterval(0)
        
        if animated {
            duration = animationDuration
        }
        
        UIView.animate(withDuration: duration) {
            self.slider.transform = CGAffineTransform(translationX: CGFloat(self.selectedIndex) * (UIScreen.width / CGFloat(self.tabs.count)), y: 0)
        }
    }
}














