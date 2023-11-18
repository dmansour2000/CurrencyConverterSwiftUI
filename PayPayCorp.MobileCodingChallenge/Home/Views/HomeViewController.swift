//
//  HomeViewController.swift
//  Challenge
//
//  Created by Dina Mansour on 11/24/19.
//  Copyright © 2019 Dina Mansour. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: AppBaseViewController {
    @IBOutlet weak var arithmeticBTN: UIButton!
    @IBOutlet weak var aboutArchitectureBTN: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
      }
    
    override func viewWillAppear(_ animated: Bool) {
        setNeedsStatusBarAppearanceUpdate()
        let btn1 = UIButton()
        btn1.setImage(UIImage(named: "menu"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        btn1.addTarget(self, action: #selector(openSideMenu(_:)), for: .touchUpInside)
        let customView = UIView()
        customView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        customView.addSubview(btn1)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: customView), animated: true);
        self.navigationItem.title = "HOME"
         arithmeticBTN.roundCorners(corners: UIRectCorner(rawValue: 15), radius: 15)
        // .Selected
           let mySelectedAttributedTitle = NSAttributedString(string: "Currency Converter",
                                                              attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
           arithmeticBTN.setAttributedTitle(mySelectedAttributedTitle, for: .selected)

           // .Normal
           let myNormalAttributedTitle = NSAttributedString(string: "Currency Converter",
                                                            attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])


        arithmeticBTN.setAttributedTitle(myNormalAttributedTitle, for: .normal)
       
        aboutArchitectureBTN.roundCorners(corners: UIRectCorner(rawValue: 15), radius: 15)
        // .Selected
             let mySelectedAttributedTitle2 = NSAttributedString(string: "About Architecture",
                                                                attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
             aboutArchitectureBTN.setAttributedTitle(mySelectedAttributedTitle2, for: .selected)

             // .Normal
             let myNormalAttributedTitle2 = NSAttributedString(string: "About Architecture",
                                                              attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])


         aboutArchitectureBTN.setAttributedTitle(myNormalAttributedTitle2, for: .normal)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
          setupSideMenu()
        }


        fileprivate func setupSideMenu() {
            // Define the menus
            
            let leftViewController:SideMenuNavigationController = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "UISideMenuNavigationController") as! SideMenuNavigationController
            SideMenuManager.default.leftMenuNavigationController = leftViewController
            SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view )
            SideMenuManager.default.menuPresentMode = .menuSlideIn
            SideMenuManager.default.menuAnimationBackgroundColor = UIColor.clear
            SideMenuManager.default.menuWidth = 280
            
        }
    
    @IBAction func goToArithmeticChallenge(_ sender: Any) {
        
        let currencyConverterViewController = CurrencyConverterViewController(nibName: "CurrencyConverterViewController", bundle: nil)
        self.navigationController?.pushViewController(currencyConverterViewController, animated: true)
    }
    @IBAction func goToAboutArchitecture(_ sender: Any) {
        
        let aboutArchitectureViewController = AboutArchitectureViewController(nibName: "AboutArchitectureViewController", bundle: nil)
              self.navigationController?.pushViewController(aboutArchitectureViewController, animated: true)
        
    }
    
    @IBAction func openSideMenu(_ sender: Any) {
          present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
      }




}
