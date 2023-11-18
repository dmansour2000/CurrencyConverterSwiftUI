//
//  SecondCurrencyViewController.swift
//  Challenge
//
//  Created by Dina Mansour on 11/25/19.
//  Copyright © 2019 Dina Mansour. All rights reserved.
//

import UIKit

class SecondCurrencyViewController: AppBaseViewController {
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var calculateBTN: UIButton!
    @IBOutlet weak var baseTextField: UITextField!
    @IBOutlet weak var currencyLabel: UILabel!
    public var base: String = ""
    public var currency: String = ""
    public var rate: Double = 1.0
    override var preferredStatusBarStyle: UIStatusBarStyle {
              return .lightContent
          }
        
        override func viewWillAppear(_ animated: Bool) {
            setNeedsStatusBarAppearanceUpdate()
           
            self.navigationItem.title = "Currency Converter"
           
            calculateBTN.roundCorners(corners: UIRectCorner(rawValue: 15), radius: 15)
                 // .Selected
                    let mySelectedAttributedTitle = NSAttributedString(string: "Calculate",
                                                                       attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
                    calculateBTN.setAttributedTitle(mySelectedAttributedTitle, for: .selected)

                    // .Normal
                    let myNormalAttributedTitle = NSAttributedString(string: "Calculate",
                                                                     attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])


                 calculateBTN.setAttributedTitle(myNormalAttributedTitle, for: .normal)
                
            baseTextField.addGreyBottomBorder(string: "")
                
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        baseLabel.text = base
        currencyLabel.text = currency
        rateLabel.text = "\(rate)"
        baseTextField.text = NSString(format: "%i", 1) as String
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SecondCurrencyViewController.tapRecognized))
          singleTapGestureRecognizer.numberOfTapsRequired = 1
          singleTapGestureRecognizer.isEnabled = true
          singleTapGestureRecognizer.cancelsTouchesInView = false
          self.view.addGestureRecognizer(singleTapGestureRecognizer)
                        }

    @objc func tapRecognized() {
              view.endEditing(true)
                        }

    @IBAction func calculate(_ sender: Any) {
        
        if (baseTextField.text != "" && UIHelper.isStringAnInt(stringNumber: baseTextField.text!)){
            let newBase = Double(baseTextField.text!)!
            let answer = newBase * rate
            rateLabel.text = "\(answer)"
            
        }else{
            showErrorMessage("Please enter a whole number to be converted!")
        }
        
        
    }
    

}
