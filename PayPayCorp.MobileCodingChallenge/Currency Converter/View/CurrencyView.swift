//
//  ContentView.swift
//  PayPayCorp.MobileCodingChallenge
//
//  Created by Dina Mansour on 18/11/2023.
//

import SwiftUI
import Combine

struct CurrencyView: View {
    @State private var amount: String = "0"
    @State private var allrates: [Double] = [Double]()
    @ObservedObject var model = Currency()
    
    var body: some View {
        
        if (model.dict.count > 0){
            VStack{
                HStack {
                    Text("Enter Amount:")
                    TextField("Amount", text: $amount)
                        .keyboardType(.numberPad)
                        .onReceive(Just(amount), perform: { newValue in
                            if (amount == "" &&  ( !UIHelper.isStringAnInt(stringNumber: amount) || !UIHelper.isStringADecimalNumber(stringNumber: amount))){
                                UIHelper.showErrorMessage("Please enter a number")
                            }else{
                                allrates = goToCalculate(amount: amount, frombaseCurrency: model.dict.allKeys[model.selectedCurrency] as! String)
                            }}
                        )
                    
                    Text("Choose Convert Base Rate Currency:")
                    
                    Picker(selection: $model.selectedCurrency, label: Text("Base Currency")) {
                        ForEach(0 ..< (model.dict.count)) {
                            Text("\(model.dict.allKeys[$0] as! String)").tag($0)
                        }.onChange(of: model.selectedCurrency, {
                            if (amount == "" &&  ( !UIHelper.isStringAnInt(stringNumber: amount) || !UIHelper.isStringADecimalNumber(stringNumber: amount))){
                                UIHelper.showErrorMessage("Please enter a number")
                            }else{
                                allrates = goToCalculate(amount: amount, frombaseCurrency: model.dict.allKeys[model.selectedCurrency] as! String)
                            }
                        })
                        
                    }
                }
                
                /*  HStack {
                    Button(action: {
                     if (amount == "" && ( !UIHelper.isStringAnInt(stringNumber: amount) || !UIHelper.isStringADecimalNumber(stringNumber: amount))){
                     UIHelper.showErrorMessage("Please enter a number")
                     }else{
                     allrates = goToCalculate(amount: amount, frombaseCurrency: model.dict.allKeys[model.selectedCurrency] as! String)
                     }
                     
                     } ) { Text("Calculate") }
                }*/
                    if (allrates.count>0){
                        let columns = [
                                GridItem(.fixed(300))
                            ]
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 20) {
                            VStack{
                                ForEach(0 ..< (model.dictRates.count)) {
                                
                                        Text("\(model.dictRates.allKeys[$0] as! String)")
                                        Text("\(String(allrates[$0]))")
                                    }
                                }
                            }
                            .padding(.horizontal)
            }
                        .frame(maxHeight: 600)
                }
                
            }
            
        }
    }
    
    func  goToCalculate(amount: String, frombaseCurrency: String) -> [Double]{
        var rate = 1.0
        var rateArray : [Double] = [Double]()
        
        if (model.dictRates.count>0){
            
            
            for i in 0 ..< model.dictRates.count{
                rate = (model.dictRates.allValues[i] as? Double)!
                var answer: Double = 0.0
                if (amount != "" && (UIHelper.isStringAnInt(stringNumber: amount) || UIHelper.isStringADecimalNumber(stringNumber: amount))){
                    var newBase = Double(amount)!
                    answer = newBase * rate
                    var rounded = round(answer * 100)
                    rateArray.append(rounded/100)
            }
        }
        
        }
        
        return rateArray
    }
    
   
    
    
}

#Preview {
    CurrencyView(model: Currency())
}
