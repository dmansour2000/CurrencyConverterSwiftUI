//
//  AppDelegate.swift
//  Challenge
//
//  Created by Dina Mansour on 11/22/19.
//  Copyright © 2019 Dina Mansour. All rights reserved.
//

import UIKit
import SideMenu
import DeviceKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
      
       var mainNavigation : UINavigationController?
    internal let currentDevice = Device.unknown("")
       fileprivate var fontSize: CGFloat {
           get {
               if currentDevice == .iPhone6
                   || currentDevice == .iPhone6s
                   || currentDevice == .iPhone7
                   || currentDevice == .simulator(.iPhone6)
                   || currentDevice == .simulator(.iPhone6s)
                   || currentDevice == .simulator(.iPhone7) {
                   
                   return 9.0
                   
               } else if currentDevice == .iPhone5
                   || currentDevice == .iPhone5s
                   || currentDevice == .iPhoneSE
                   || currentDevice == .simulator(.iPhone5)
                   || currentDevice == .simulator(.iPhone5s)
                   || currentDevice == .simulator(.iPhoneSE) {
                   
                   return 8.0
               }
               
               return 10.0
           }
       }
       
       //MARK: Device
       internal func isPad() -> Bool {
           return currentDevice.isPad
       }
       
       internal func isIphoneX() -> Bool {
           return (currentDevice == .iPhoneX || currentDevice == .simulator(.iPhoneX))
       }
       
       internal func isInIphone5Family() -> Bool {
           if currentDevice == .iPhone5
               || currentDevice == .iPhone5s
               || currentDevice == .iPhoneSE
               || currentDevice == .simulator(.iPhone5)
               || currentDevice == .simulator(.iPhone5s)
               || currentDevice == .simulator(.iPhoneSE) {
               return true
           }
           return false
       }
       
       internal func isNotIphoneXFamily() -> Bool {
           if currentDevice == .iPhone5
               || currentDevice == .iPhone5s
               || currentDevice == .iPhoneSE
               || currentDevice == .iPhone5c
               || currentDevice == .iPhone6
               || currentDevice == .iPhone6Plus
               || currentDevice == .iPhone6s
               || currentDevice == .iPhone6sPlus
               || currentDevice == .iPhone7
               || currentDevice == .iPhone7Plus
               || currentDevice == .iPhone8
               || currentDevice == .iPhone8Plus
               || currentDevice == .simulator(.iPhone5)
               || currentDevice == .simulator(.iPhone5s)
               || currentDevice == .simulator(.iPhoneSE)
               || currentDevice == .simulator(.iPhone5c)
               || currentDevice == .simulator(.iPhone6)
               || currentDevice == .simulator(.iPhone6Plus)
               || currentDevice == .simulator(.iPhone6s)
               || currentDevice == .simulator(.iPhone6sPlus)
               || currentDevice == .simulator(.iPhone7)
               || currentDevice == .simulator(.iPhone7Plus)
               || currentDevice == .simulator(.iPhone8)
               || currentDevice == .simulator(.iPhone8Plus){
               return true
           }
           return false
       }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.hexStringToUIColor(hex: "#3BBCF8")]
        
         UIApplication.shared.statusBarStyle = .lightContent
        
        //Initialize MainNavigationController
        let mainViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        mainNavigation = UINavigationController.init(rootViewController: mainViewController)
       // mainNavigation?.isNavigationBarHidden = true
        mainNavigation!.modalPresentationStyle = .fullScreen
        

        mainNavigation!.navigationBar.barTintColor = Constants.hexStringToUIColor(hex: "#000000")
        mainNavigation!.navigationBar.tintColor = Constants.hexStringToUIColor(hex: "#3BBCF8")
        
         self.window = UIWindow.init(frame: UIScreen.main.bounds)
                   
                  
               
        self.window?.rootViewController = mainNavigation
                       
               
                   
                   
                   
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = UIColor.white
        
                   
        return true
    }
        
  
        


  


}

