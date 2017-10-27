//
//  ATToastMessageTool.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/21.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit
import SnapKit

class ATToastMessageTool {
    
    /// MARK: *** 单例 ***
    
    static let shared = ATToastMessageTool()
    private init() {}
    
    /// MARK: *** 属性 ***
    
    private lazy var messageView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(white: 0, alpha: 0.8)
        view.alpha = 0.0
        view.layer.cornerRadius = 2.0
        view.layer.masksToBounds = true
        
        return view
    }()
    private lazy var messageLbl: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = .footnote
        label.textAlignment = .center
        messageView.addSubview(label)
        
        label.snp.makeConstraints({ (make) in
            make.center.equalTo(messageView)
        })
        
        return label
    }()
    private var task: DispatchQueue.Task?
    
    /// MARK: *** 逻辑 ***
    
    ///显示一条提示
    func show(_ message: String, on view: UIView? = Constant.window, showDuration: TimeInterval = 1.0, disappearDuration: TimeInterval = 0.5, completed: ((Bool) -> Void)? = nil) {
        if message.isEmpty {
            return
        }
        DispatchQueue.main.cancel(task)
        
        let size = message.renderSize(font: .footnote)
        
        view?.addSubview(messageView)
        
        messageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(UIScreen.width * 0.5)
            make.centerY.equalTo(UIScreen.height * 0.85)
            make.width.equalTo(min(UIScreen.width - 40, size.width + 20))
            make.height.equalTo(size.height + 10)
        }
        
        messageView.alpha = 1.0
        messageLbl.text = message
        
        task = DispatchQueue.main.delay(time: showDuration, task: {
            UIView.animate(withDuration: disappearDuration, animations: {
                self.messageView.alpha = 0.0
            }, completion: { (finished) in
                completed?(finished)
                self.messageView.removeFromSuperview()
            })
        })
    }
}
