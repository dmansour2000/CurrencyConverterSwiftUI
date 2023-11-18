//
//  AppBaseViewController.swift
//
//
//  Created by Dina Mansour on 9/2/19.
//  Copyright © 2019 Dina Mansour. All rights reserved.
//

import UIKit
import Reachability

class AppBaseViewController: UIViewController {
    
    var dialogFullScreenView: UIView?
    var dialogLoadingGroup: STLoadingGroup?
  
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:.plain, target: nil, action: nil)
    }
    
    internal func showProgressDialog(){
        dialogLoadingGroup = STLoadingGroup(side: 80, style: .arch)
        
        if dialogFullScreenView == nil {
            dialogFullScreenView = UIView(frame: self.view.frame)
            dialogFullScreenView?.backgroundColor = UIColor(red: 0.0, green: 0.0, blue:0.0, alpha: 0.3)
        }
        
        if !(dialogFullScreenView?.isDescendant(of: self.view))!{
            self.view.addSubview(dialogFullScreenView!)
            dialogFullScreenView?.fillScreenLayoutConstrains()
        }
        
        dialogLoadingGroup?.show(dialogFullScreenView)
        dialogLoadingGroup?.startLoading()
    }
    
    internal func hideProgressDialog(){
        dialogLoadingGroup?.stopLoading()
        dialogFullScreenView?.removeFromSuperview()
    }
    
    
    
    
    public func isNetworkConnected() -> Bool{
        var reachability: Reachability
        do {
            try  reachability = Reachability()
             return reachability.isReachable
        } catch is NSError {
          
        }
       
       return false
    }
    
    internal func showNoNetworkConnectedMessage(){
        UIHelper.showErrorMessage("noNetworkConnected")
    }
    
    internal func showSuccessMessage(_ message: String){
        UIHelper.showSuccessMessage(message)
    }
    internal func showErrorMessage(_ message: String){
        UIHelper.showErrorMessage(message)
    }
    
    
    //MARK: Theme Helpers
    internal func setBiggerNavBarViewTitle(withTitle titleText: String) {
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        title = titleText
    }
    
    //MARK: Custom NavigationBars (Setup)
    internal func addBiggerNavigationBar(backgroundColor: UIColor = UIColor.themeColor(), showShadow: Bool = true, showBottomBorder: Bool = true, withExtraTitleTopMargin topMargin: CGFloat = 0.0, isNormalTitleLabel: Bool = false) {
        
        let navBarWidth: CGFloat = UIScreen.screenSize().width
        let navBarHeight: CGFloat = self.biggerNavBarHeight()
        let biggerNavBarView = UIView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: navBarWidth, height: navBarHeight)))
        biggerNavBarView.backgroundColor = backgroundColor
        biggerNavBarView.tag = Constants.CustomNavBarTags.BiggerNavBar
        if showShadow {
            biggerNavBarView.layer.shadowOffset = CGSize(width: 0, height: 5.0)
            biggerNavBarView.layer.shadowOpacity = 0.1
            biggerNavBarView.layer.shadowRadius = 5.0
            biggerNavBarView.layer.shouldRasterize = true
            biggerNavBarView.layer.rasterizationScale = UIScreen.main.scale
            biggerNavBarView.layer.shadowColor = UIColor.black.cgColor
        }
        self.view.addSubview(biggerNavBarView)
        if isNormalTitleLabel {
            self.addTitleInNavigationBar(withExtraTopMargin: topMargin)
        } else {
            self.addBiggerTitleInNavigationBar(withExtraTopMargin: topMargin)
        }
        if showBottomBorder {
            biggerNavBarView.addBorder(side: .bottom, thickness: 2.0, color: UIColor.black.withAlphaComponent(0.1))
        }
    }
    
    internal func addSmallerNavigationBar(backgroundColor: UIColor = UIColor.themeColor(), showShadow: Bool = true, showBottomBorder: Bool = true, withExtraTitleTopMargin topMargin: CGFloat = 0.0, isNormalTitleLabel: Bool = false) {
        
        let navBarWidth: CGFloat = UIScreen.screenSize().width
        let navBarHeight: CGFloat = self.smallerNavBarHeight()
        let biggerNavBarView = UIView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: navBarWidth, height: navBarHeight)))
        biggerNavBarView.backgroundColor = backgroundColor
        biggerNavBarView.tag = Constants.CustomNavBarTags.BiggerNavBar
        if showShadow {
            biggerNavBarView.layer.shadowOffset = CGSize(width: 0, height: 5.0)
            biggerNavBarView.layer.shadowOpacity = 0.1
            biggerNavBarView.layer.shadowRadius = 5.0
            biggerNavBarView.layer.shouldRasterize = true
            biggerNavBarView.layer.rasterizationScale = UIScreen.main.scale
            biggerNavBarView.layer.shadowColor = UIColor.black.cgColor
        }
        self.view.addSubview(biggerNavBarView)
        if isNormalTitleLabel {
            self.addTitleInNavigationBar(withExtraTopMargin: topMargin)
        } else {
            self.addBiggerTitleInNavigationBar(withExtraTopMargin: topMargin)
        }
        if showBottomBorder {
            biggerNavBarView.addBorder(side: .bottom, thickness: 2.0, color: UIColor.black.withAlphaComponent(0.1))
        }
    }
    
    fileprivate func addBiggerTitleInNavigationBar(withExtraTopMargin topMargin: CGFloat = 0.0) {
        if let navBarView = self.biggerNavBarView() {
            let initialMargin = CGFloat(20.0)
            let height = CGFloat(40.0)
            let width = CGFloat(navBarView.width() - (initialMargin * 2.0))
            let titleLabel = UILabel.init(frame: CGRect.init(origin: CGPoint.init(x: initialMargin, y: 0.0), size: CGSize.init(width: width, height: height)))
            titleLabel.numberOfLines = 2
            titleLabel.textColor = UIColor.black
            titleLabel.backgroundColor = UIColor.clear
            titleLabel.font = UIFont.languageSpecificFont(style: [.heavy, .bold], size: [24.0, 30.0], font: [.SFProDisplay, .Cairo])
            titleLabel.textAlignment = .languagePrefersTextAlignment()
            titleLabel.tag = Constants.CustomNavBarTags.BiggerTitleLabel
            navBarView.addSubview(titleLabel)
            titleLabel.center = CGPoint.init(x: titleLabel.center.x, y: navBarView.height()/2.0 + buttonsTopMargin() + topMargin)
        }
    }
    
    fileprivate func addTitleInNavigationBar(withExtraTopMargin topMargin: CGFloat = 0.0) {
        if let navBarView = self.biggerNavBarView() {
            let numberOfButtonsInNavBarView: CGFloat = 1
            let titleSize = navBarView.width() - ((numberOfButtonsInNavBarView * buttonsSize()) + (numberOfButtonsInNavBarView * buttonsInternalMargin()))
            let titleLabel = UILabel.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: titleSize, height: 60.0)))
            titleLabel.numberOfLines = 2
            titleLabel.textColor = UIColor.RGB(r: 47.0, g: 45.0, b: 45.0)
            titleLabel.backgroundColor = UIColor.clear
            titleLabel.font = UIFont.languageSpecificFont(style: [.bold, .bold], size: [14.0, 17.0], font: [.SFProDisplay, .Cairo])
            titleLabel.textAlignment = .center
            titleLabel.tag = Constants.CustomNavBarTags.TitleLabel
            navBarView.addSubview(titleLabel)
            titleLabel.center = CGPoint.init(x: navBarView.width()/2.0, y: navBarView.height()/2.0 + buttonsTopMargin() + topMargin)
        }
    }
    
    internal func addBackButton() {
       
            //let imgBackArrowLeft: UIImage = #imageLiteral(resourceName: "black_arrow_left")
            let imgBackArrowLeft : UIImage? = #imageLiteral(resourceName: "black_arrow_left").withRenderingMode(.alwaysOriginal)
            self.navigationController?.navigationBar.backIndicatorImage = imgBackArrowLeft
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBackArrowLeft
            self.navigationController?.navigationBar.semanticContentAttribute = .forceLeftToRight
        
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    //MARK: UI Helpers
    fileprivate func buttonsInternalMargin() -> CGFloat {
        return 5.0
    }
    
    fileprivate func buttonsTopMargin() -> CGFloat {
        return 5.0
    }
    
    fileprivate func buttonsSize() -> CGFloat {
        return 50.0
    }
    
    internal func biggerNavBarHeight() -> CGFloat {
        if self.sharedDelegate.isIphoneX() {
            let heightOfNotch: CGFloat = 30.0
            return (84.0 + heightOfNotch)
        }
        return 84.0
    }
    
    internal func smallerNavBarHeight() -> CGFloat {
        return self.sharedDelegate.isNotIphoneXFamily() ? 65.0 : 84.0
    }
    
    //MARK: Getters
    internal func biggerNavBarView() -> UIView? {
        return self.view.viewWithTag(Constants.CustomNavBarTags.BiggerNavBar)
    }
    
    internal func viewHeightWithoutNavBar() -> CGFloat {
        return (UIScreen.screenSize().height - self.biggerNavBarHeight())
    }
    
    internal func viewWidth() -> CGFloat {
        return UIScreen.screenSize().width
    }
    
    //MARK: Theme Helpers
    internal func setBiggerNavBarViewTitles(withTitle title: String) {
        if let titleLabel = (self.view.viewWithTag(Constants.CustomNavBarTags.BiggerTitleLabel) as? UILabel) {
            titleLabel.text = title
        }
    }
    
    internal func setNormalNavBarViewTitle(withTitle title: String) {
        if let titleLabel = (self.view.viewWithTag(Constants.CustomNavBarTags.TitleLabel) as? UILabel) {
            titleLabel.text = title
        }
    }
    
    internal func setBiggerNavBarViewTitleColor(withColor color: UIColor) {
        if let titleLabel = (self.view.viewWithTag(Constants.CustomNavBarTags.BiggerTitleLabel) as? UILabel) {
            titleLabel.textColor = color
        }
    }
    
    internal func setNormalNavBarViewTitleColor(withColor color: UIColor) {
        if let titleLabel = (self.view.viewWithTag(Constants.CustomNavBarTags.TitleLabel) as? UILabel) {
            titleLabel.textColor = color
        }
    }
    
    internal func setBiggerNavBarViewTitleFont(withFont font: UIFont) {
        if let titleLabel = (self.view.viewWithTag(Constants.CustomNavBarTags.BiggerTitleLabel) as? UILabel) {
            titleLabel.font = font
        }
    }
    
    internal func setNormalNavBarViewTitleFont(withFont font: UIFont) {
        if let titleLabel = (self.view.viewWithTag(Constants.CustomNavBarTags.TitleLabel) as? UILabel) {
            titleLabel.font = font
        }
    }
    
    internal func updateBiggerNavigationTitle() {
        if let titleLabel = (self.view.viewWithTag(Constants.CustomNavBarTags.BiggerTitleLabel) as? UILabel) {
            titleLabel.textAlignment = .languagePrefersTextAlignment()
            titleLabel.font = UIFont.languageSpecificFont(style: [.heavy, .bold], size: [24.0, 30.0], font: [.SFProDisplay, .Cairo])
        }
    }
}
