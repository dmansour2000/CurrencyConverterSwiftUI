//
//  CurrencyConverterViewController.swift
//  Challenge
//
//  Created by Dina Mansour on 11/24/19.
//  Copyright © 2019 Dina Mansour. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SideMenu

class CurrencyConverterViewController: AppBaseViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var baseLabel: UILabel!
    let disposeBag = DisposeBag()
    var model: BaseModel!
    
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
             self.navigationItem.title = "Currency Converter"
            
         }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
         tableView.register(UINib(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "Currency")
        // Do any additional setup after loading the view.
       setupSideMenu()
        
        if isNetworkConnected(){
                   showProgressDialog()
                   callNetwork()
               }else{
                   showNoNetworkConnectedMessage()
               }
               
        
             }

    func callNetwork(){
          
          let viewModel = CurrencyConverterViewModel()
          
          
          
        viewModel.currencyConverter()
              .observeOn(MainScheduler.instance)
              .subscribe(onNext: { [unowned self] model in
                  
                 
                if (model.rates.allKeys.count != 0){
                      self.model = model
                      self.baseLabel.text = "Base Currency: " + self.model.base
                      self.tableView!.reloadData()
                  }
                  
              
       
             self.hideProgressDialog()
                  
              })
              .disposed(by: disposeBag)
          
          
        
          
          
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


    @IBAction func openSideMenu(_ sender: Any) {
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }

    
    // MARK: - Table view data source
      
      func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        if (model != nil ) {
            return model.rates.allKeys.count
        } else{
            return 0
        }
      }
      
      
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
        
             
        let cell = tableView.dequeueReusableCell(withIdentifier: "Currency", for: indexPath) as! CurrencyTableViewCell
       let dict = model.rates
       cell.currency.text = dict.allKeys[indexPath.row] as? String
        let rate = dict.allValues[indexPath.row] as? Double
        cell.rate.text = "\(rate ?? 0.0)"
        
              
              return cell
          
          
      }
       
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
      {
          
    
              return 44
          
      }
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
          
          
          
        let secondCurrencyViewController = SecondCurrencyViewController(nibName: "SecondCurrencyViewController", bundle: nil)
        secondCurrencyViewController.base = model.base
        let dict = model.rates
        secondCurrencyViewController.currency = (dict.allKeys[indexPath.row] as? String)!
        secondCurrencyViewController.rate = (dict.allValues[indexPath.row] as? Double)!
        self.navigationController?.pushViewController(secondCurrencyViewController, animated: true)
              
          
       
    
}
}
