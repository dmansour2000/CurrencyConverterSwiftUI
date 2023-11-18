//
//  SideMenuViewController.swift
// 
//
//  Created by Dina Mansour on 9/2/19.
//  Copyright © 2019 Dina Mansour. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuViewController: UITableViewController {

  
    var images: [String] = [ "HEADER", "home", "currency"]
    var text: [String] = [ "HEADER", "Home", "Currency Converter"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.register(UINib(nibName: "HeaderSideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderSideMenu")
        tableView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenu")
      
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return text.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
            if (indexPath.row == 0){
                     let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderSideMenu", for: indexPath) as! HeaderSideMenuTableViewCell
                    
                      return cell
            }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenu", for: indexPath) as! SideMenuTableViewCell
            cell.icon.image = UIImage(named: images[indexPath.row])
            cell.label.text = text[indexPath.row]
            
            return cell
        }
        
    }
     
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(indexPath.row==0)
               {
                   
                   
            return 140
        }else {
  
            return 44
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
        
     if(indexPath.row==1)
        {
            let homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
            self.navigationController?.pushViewController(homeViewController, animated: true)
            
        }
        else if(indexPath.row==2)
        {
            let currencyConverterViewController = CurrencyConverterViewController(nibName: "CurrencyConverterViewController", bundle: nil)
            self.navigationController?.pushViewController(currencyConverterViewController, animated: true)
            
        }
          
        
    }
    
}
