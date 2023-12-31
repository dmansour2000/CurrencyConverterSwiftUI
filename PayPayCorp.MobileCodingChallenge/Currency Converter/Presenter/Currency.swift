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
    @Published var listofcurrenciesviewModel = ListofCurrenciesViewModel()
    @Published var currencyConverterViewModel = CurrencyConverterViewModel()
    @Published var dict: NSDictionary = [:]
    @Published var dictRates: NSDictionary = [:]
    let disposeBag = DisposeBag()
    var dialogFullScreenView: UIView?
    var dialogLoadingGroup: STLoadingGroup?
    
    init(){
        if isNetworkConnected(){
            showProgressDialog()
            callNetwork()
            getBaseRates()} else{
                showNoNetworkConnectedMessage()
            }
    }
    
    func getBaseRates(){
        
        currencyConverterViewModel.currencyConverter()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                model in
                
                if (model.rates.count != 0){
                    self.dictRates  = model.rates
                }
                
                self.hideProgressDialog()
                
            })
            .disposed(by: disposeBag)
        
    }
    
    func callNetwork(){
       
        listofcurrenciesviewModel.listOfCurrencies()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                model in
                
                if (model.result.count != 0){
                    self.dict  = model.result
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
