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

protocol LSPageTabViewDatasource {
    func numberOfTab(in pageTabView: LSPageTabView) -> Int
    func pageTabView(_ pageTabView: LSPageTabView, childViewAt index: Int) -> UIView
}

class LSPageTabView: UIView {
    
    // MARK: *** 属性 ***
    
    ///当前类型 固定/可滚动
    private var type: LSPageTabViewType = .stationary
    
    ///代理
    public var dataSource: LSPageTabViewDatasource? {
        didSet {
            if let tabCount = dataSource?.numberOfTab(in: self) {
                for i in 0 ..< tabCount {
                    let tab = UIButton(type: .custom)
                    tab.tag = i
                    tab.addTarget(self, action: #selector(tapOnTabBtn), for: .touchUpInside)
                    tab.backgroundColor = UIColor.random()
                    tabs.append(tab)
                    tabBar.addSubview(tab)
                    
                    if let childView = dataSource?.pageTabView(self, childViewAt: i) {
                        chileViews.append(childView)
                        mainScrollView.addSubview(childView)
                    }
                }
                tabBar.addSubview(slider)
            }
        }
    }
    
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
    ///标签数量
    private var tabsCount: Int {
        get {
            return tabs.count
        }
    }
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
        view.layer.cornerRadius = sliderCornerRadius
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
    
    ///主题ScrollView
    private lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        return scrollView
    }()
    
    ///子View列表
    private var chileViews: [UIView] = []
    
    ///当前所选索引
    private var selectedIndex: Int = 0
    
    // MARK: *** 构造方法 ***
    
    convenience init(type: LSPageTabViewType) {
        self.init()
        
        self.type = type
        
        addSubview(tabBar)
        addSubview(mainScrollView)
    }
    
    // MARK: *** 布局 ***
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tabBar.frame.origin = CGPoint(x: 0, y: 0)
        tabBar.frame.size = CGSize(width: width, height: tabBarHeight)
        
        let tabWidth = width / CGFloat(tabsCount)
        for (idx, tab) in tabs.enumerated() {
            tab.frame = CGRect(x: CGFloat(idx) * tabWidth, y: 0, width: tabWidth, height: tabBarHeight)
        }
        slider.frame = CGRect(x: CGFloat(selectedIndex) * tabWidth, y: tabBar.height - sliderVisibleHeight, width: tabWidth, height: sliderRealHeight)
        
        mainScrollView.frame = CGRect(x: 0, y: tabBar.height, width: width, height: height - tabBar.height)
        mainScrollView.contentSize = CGSize(width: CGFloat(tabsCount) * width, height: height - tabBar.height)
        mainScrollView.contentOffset = CGPoint(x: CGFloat(selectedIndex) * width, y: 0)

        for (idx, childView) in chileViews.enumerated() {
            childView.frame = CGRect(x: CGFloat(idx) * width, y: 0, width: width, height: height - tabBar.height)
        }
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
        mainScrollView.setContentOffset(CGPoint(x: CGFloat(index) * UIScreen.width, y: 0), animated: true)
    }
//    ///移动滑块
//    private func moveSlider(animated: Bool) {
//        var duration = TimeInterval(0)
//
//        if animated {
//            duration = animationDuration
//        }
//
//        UIView.animate(withDuration: duration) {
//            self.slider.transform = CGAffineTransform(translationX: CGFloat(self.selectedIndex) * (UIScreen.width / CGFloat(self.tabsCount)), y: 0)
//        }
//    }
}

extension LSPageTabView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        selectedIndex = Int(x / UIScreen.width)
        self.slider.transform = CGAffineTransform(translationX: x / CGFloat(tabsCount), y: 0)
    }
}














