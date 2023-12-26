//
//  Currency.swift
//  PayPayCorp.MobileCodingChallenge
//
//  Created by Dina Mansour  on 26/12/2023.
//

import Foundation
import RxSwift
import RxCocoa
import Reachability

class Currency: ObservableObject {
    @Published var selection = ""
    @Published var selectedCurrency = 0
    @Published var viewModel = CurrencyConverterViewModel()
    @Published var dict: NSDictionary = [:]
    let disposeBag = DisposeBag()
    var dialogFullScreenView: UIView?
    var dialogLoadingGroup: STLoadingGroup?
    
    init(){
        if isNetworkConnected(){
           showProgressDialog()
            callNetwork()} else{
                showNoNetworkConnectedMessage()
            }
    }
    
    func callNetwork(){
       
        viewModel.currencyConverter()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                model in
                
                if (model.rates.count != 0){
                    self.dict  = model.rates
                }
                
                self.hideProgressDialog()
                
            })
            .disposed(by: disposeBag)
        
    }
    
    func isNetworkConnected() -> Bool{
        var reachability: Reachability
        do {
            try  reachability = Reachability()
            if (reachability.connection != .unavailable){
                return true
            }
        } catch is NSError {
            
        }
        
        return false
    }
    
    func showNoNetworkConnectedMessage(){
        UIHelper.showErrorMessage("noNetworkConnected")
    }
    
    func showSuccessMessage(_ message: String){
        UIHelper.showSuccessMessage(message)
    }
    func showErrorMessage(_ message: String){
        UIHelper.showErrorMessage(message)
    }
   
    
    func showProgressDialog(){
        
        dialogLoadingGroup?.show(dialogFullScreenView)
        dialogLoadingGroup?.startLoading()
    }
    
    func hideProgressDialog(){
        dialogLoadingGroup?.stopLoading()
        dialogFullScreenView?.removeFromSuperview()
    }
    
}
