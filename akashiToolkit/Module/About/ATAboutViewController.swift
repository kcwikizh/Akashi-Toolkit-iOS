//
//  ATAboutViewController.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/27.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit
import MessageUI

class ATAboutViewController: ATViewController {
    
    // MARK: *** 属性 ***
    
    ///状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    private lazy var tableView: ATTableView = {
        let tableView = ATTableView(frame: .zero, style: .grouped)
        
        tableView.tableHeaderView = self.headerView
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: 320))
        
        view.backgroundColor = .clear
        
        view.addSubview(appLogoImv)
        view.addSubview(versionLbl)
        view.addSubview(copyrightTipsLbl)
        view.addSubview(organizationLogoImv)
        
        appLogoImv.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: 150.0, height: 150.0))
            make.centerX.equalTo(view)
            make.top.equalTo(40.0)
        })
        versionLbl.snp.makeConstraints({ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(appLogoImv.snp.bottom).offset(25.0)
        })
        copyrightTipsLbl.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: 227.0, height: 22.0))
            make.centerX.equalTo(view).offset(-22.5)
            make.top.equalTo(versionLbl.snp.bottom).offset(35.0)
        })
        organizationLogoImv.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: 35.0, height: 35.0))
            make.centerY.equalTo(copyrightTipsLbl)
            make.left.equalTo(copyrightTipsLbl.snp.right).offset(10.0)
        })
        
        return view
    }()
    
    private lazy var appLogoImv: UIImageView = UIImageView(image: UIImage(named: "appLogo")?.resizeImage(to: CGSize(width: 150.0, height: 150.0)))
    private lazy var organizationLogoImv: UIImageView = UIImageView(image: UIImage(named: "organizationLogo")?.resizeImage(to: CGSize(width: 35.0, height: 35.0)))
    private lazy var versionLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.body
        label.textColor = Constant.ui.color.auxiliaryText
        label.textAlignment = .center
        label.text = "Ver : \(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)"
        
        return label
    }()
    private lazy var copyrightTipsLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.footnote
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = true
        let website = "舰娘百科 / kcwiki"
        let str = "本APP数据均由 \(website) 提供"
        let attStr = NSMutableAttributedString(string: str)
        attStr.addAttribute(.foregroundColor, value: UIColor.blue, range: (str as NSString).range(of: website))
        attStr.addAttribute(.underlineStyle, value: 1, range: (str as NSString).range(of: website))
        label.attributedText = attStr
        
        return label
    }()
    
    // MARK: *** 周期 ***
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate = self
        modalPresentationStyle = .custom
        
        let image = UIImage(named: "close")?.resizeImage(to: CGSize(width: 15.0, height: 15.0)).withRenderingMode(.alwaysTemplate)
        leftBtn.setImage(image, for: .normal)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(navView.snp.bottom)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnCopyrightTipsLbl))
        copyrightTipsLbl.addGestureRecognizer(tap)
    }
    
    // MARK: *** 回调 ***
    
    override func leftBtnDidClick() {
        dismiss(animated: true)
    }
    @objc private func tapOnCopyrightTipsLbl() {
        if UIApplication.shared.canOpenURL(Constant.official.website) {
            UIApplication.shared.openURL(Constant.official.website)
        }
    }
    
    // MARK: *** 逻辑 ***
    
    private func presentMailController() {
        if MFMailComposeViewController.canSendMail() {
            let mailVc = MFMailComposeViewController()
            mailVc.mailComposeDelegate = self
            
            mailVc.setSubject("明石工具箱 问题反馈")
            mailVc.setToRecipients([Constant.official.developerEmail])
            mailVc.setMessageBody(" 设备型号: \(UIDevice.model) \n 系统版本: \(UIDevice.current.systemName) \(UIDevice.current.systemVersion) \n APP版本: \(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)", isHTML: false)
            
            present(mailVc, animated: true)
        } else {
            let alert = UIAlertController(title: "错误", message: "无法自动生成邮件, 请手动发送邮件至邮箱: \(Constant.official.developerEmail), 或联系QQ: \(Constant.official.developerQQ)", preferredStyle: .alert)
            let copyEmail = UIAlertAction(title: "复制邮箱地址", style: .default, handler: { _ in
                let pas = UIPasteboard.general
                pas.string = Constant.official.developerEmail
                ATToastMessageTool.show("邮箱地址已复制到剪贴板")
            })
            let copyQQ = UIAlertAction(title: "复制QQ", style: .default, handler: { _ in
                let pas = UIPasteboard.general
                pas.string = Constant.official.developerQQ
                ATToastMessageTool.show("QQ已复制到剪贴板")
            })
            let done = UIAlertAction(title: "取消", style: .default)
            
            alert.addAction(copyEmail)
            alert.addAction(copyQQ)
            alert.addAction(done)
            present(alert, animated: true)
        }
    }
}

extension ATAboutViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 1
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            if row == 0 {
                let cell = ATTableViewDisclosureIndicatorCell.forTableView(tableView as! ATTableView, at: indexPath)
                cell.textLabel?.text = "官方微博"
                return cell
            } else {
                let cell = ATTableViewDisclosureIndicatorCell.forTableView(tableView as! ATTableView, at: indexPath)
                cell.textLabel?.text = "微信公众号"
                return cell
            }
        } else {
            let cell = ATTableViewDisclosureIndicatorCell.forTableView(tableView as! ATTableView, at: indexPath)
            cell.textLabel?.text = "意见反馈"
            return cell
        }
    }
}

extension ATAboutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            if row == 0 {
                if UIApplication.shared.canOpenURL(Constant.official.weibo) {
                    UIApplication.shared.openURL(Constant.official.weibo)
                }
            } else {
                let alert = UIAlertController(title: "", message: "kcwiki舰娘百科公众号: \(Constant.official.weixin)", preferredStyle: .alert)
                let copyAndOpenWeixin = UIAlertAction(title: "复制公众号并跳转至微信", style: .default, handler: { _ in
                    let pas = UIPasteboard.general
                    pas.string = Constant.official.weixin
                    ATToastMessageTool.show("公众号已复制到剪贴板")
                    let wxURL = URL(string: "weixin://")!
                    if UIApplication.shared.canOpenURL(wxURL) {
                        UIApplication.shared.openURL(wxURL)
                    }
                })
                let done = UIAlertAction(title: "取消", style: .default)
                
                alert.addAction(copyAndOpenWeixin)
                alert.addAction(done)
                present(alert, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "反馈", message: "请根据您遇到的问题类型选择", preferredStyle: .alert)
            
            let dataQuestion = UIAlertAction(title: "数据问题: 联系编辑组", style: .default, handler: { (action) in
                if UIApplication.shared.canOpenURL(Constant.official.dataFeedback) {
                    UIApplication.shared.openURL(Constant.official.dataFeedback)
                }
            })
            let appQuestion = UIAlertAction(title: "软件问题: 联系开发者", style: .default, handler: { _ in
                self.presentMailController()
            })
            let cancel = UIAlertAction(title: "取消", style: .default)
            
            alert.addAction(dataQuestion)
            alert.addAction(appQuestion)
            alert.addAction(cancel)
            
            present(alert, animated: true)
        }
    }
}

extension ATAboutViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            ATToastMessageTool.show("已取消")
        case .saved:
            ATToastMessageTool.show("已保存")
        case .sent:
            ATToastMessageTool.show("已发送")
        case .failed:
            ATToastMessageTool.show("发送失败")
        }
        controller.dismiss(animated: true)
    }
}

extension ATAboutViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ATAboutViewControllerPresent()
    }
}

private class ATAboutViewControllerPresent: NSObject {}

extension ATAboutViewControllerPresent: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! ATAboutViewController
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        //画两个圆路径
        let startCycle = UIBezierPath(arcCenter: CGPoint(x: UIScreen.width * 0.5, y: Constant.ui.size.topHeight + 40.0 + 150.0 * 0.5), radius: 30.0, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let endCycle = UIBezierPath(arcCenter: CGPoint(x: UIScreen.width * 0.5, y: UIScreen.height * 0.5), radius: UIScreen.height * 0.8, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        //创建遮盖
        let maskLayer = CAShapeLayer()
        maskLayer.path = endCycle.cgPath;
        toVC.view.layer.mask = maskLayer;
        //创建路径动画
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.delegate = self;
        maskLayerAnimation.fromValue = startCycle.cgPath
        maskLayerAnimation.toValue = endCycle.cgPath
        maskLayerAnimation.duration = self.transitionDuration(using: transitionContext)
        maskLayerAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        maskLayerAnimation.setValue(transitionContext, forKey: "transitionContext")
        maskLayer.add(maskLayerAnimation, forKey: "path")
    }
}

extension ATAboutViewControllerPresent: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let transitionContext = anim.value(forKey: "transitionContext") as? UIViewControllerContextTransitioning {
            transitionContext.completeTransition(true)
        }
    }
}
