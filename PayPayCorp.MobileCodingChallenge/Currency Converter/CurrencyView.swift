//
//  ContentView.swift
//  PayPayCorp.MobileCodingChallenge
//
//  Created by Dina Mansour on 18/11/2023.
//

import SwiftUI
import RxSwift
import RxCocoa
import Reachability

struct CurrencyView: View {
    @State private var selection: String = " "
    @State private var amount: String = "0.0"
    @State private var rate: Double = 0.0
    @State private var selectedCurrency: Int = 0
    let disposeBag = DisposeBag()
    var dialogFullScreenView: UIView?
    var dialogLoadingGroup: STLoadingGroup?
    @State private var dict: NSDictionary = [:]
    
    
    var body: some View {
        
        VStack {
            Button(action: {
                if isNetworkConnected(){
                    showProgressDialog()
                    callNetwork()} else{
                        showNoNetworkConnectedMessage()
                    }
                
                
            }){ Text("Load Currencies and Rates") }
            
            TextField("Amount", text: $amount)
            if (dict.count>0){
                Picker("Base Currency", selection: $selection) {
                    ForEach(0 ..< dict.count) {
                        Text("\(dict.allKeys[$0] as! String)").tag(selectedCurrency)
                    }
                }.pickerStyle(MenuPickerStyle())
                 .onChange(of: selection, perform:  { ForEach(0 ..< dict.count) { newValue in
                        Text("\(dict.allKeys[newValue] as! String)").tag(selectedCurrency)
                        
                    }})
                Button(action: {
                    rate = goToCalculate(amount: self.amount)
                    
                } ) { Text("Calculate") }
                Text(String(rate))
                
            }
        }
    }
    
    func callNetwork(){
     var viewModel = CurrencyConverterViewModel()
        viewModel.currencyConverter()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                model in
                
                if (model.rates.count != 0){
                    dict  = model.rates
                }
                
                hideProgressDialog()
                
            })
            .disposed(by: disposeBag)
        
    }
    
    
    func  goToCalculate(amount: String) -> Double{
        var rate = 1.0
        if (dict.count>0){
            rate = (dict.allValues[selectedCurrency] as? Double)!
        }
        var answer: Double = 0.0
        if (amount != "" && UIHelper.isStringAnInt(stringNumber: amount)){
            var newBase = Double(amount)!
            answer = newBase * rate
        }
        
        answer
    }
    
    func showProgressDialog(){
        
        dialogLoadingGroup?.show(dialogFullScreenView)
        dialogLoadingGroup?.startLoading()
    }
    
    func hideProgressDialog(){
        dialogLoadingGroup?.stopLoading()
        dialogFullScreenView?.removeFromSuperview()
    }
    
    
    
    
    func isNetworkConnected() -> Bool{
        var reachability: Reachability
        do {
            try  reachability = Reachability()
            reachability.connection != .unavailable
        } catch is NSError {
            
        }
        
        false
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
    }
    

#Preview {
    CurrencyView()
}
