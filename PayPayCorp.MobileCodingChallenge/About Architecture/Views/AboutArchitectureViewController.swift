//
//  AboutArchitectureViewController.swift
//  Challenge
//
//  Created by Dina Mansour on 11/24/19.
//  Copyright © 2019 Dina Mansour. All rights reserved.
//

import UIKit

class AboutArchitectureViewController: AppBaseViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
      
      override func viewWillAppear(_ animated: Bool) {
          setNeedsStatusBarAppearanceUpdate()
         
          self.navigationItem.title = "About Architecture"
         
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



}
