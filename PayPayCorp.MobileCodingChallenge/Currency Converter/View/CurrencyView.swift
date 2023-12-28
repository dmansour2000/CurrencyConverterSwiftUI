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
    @State private var rate: Double = 0.0
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
                            if (amount == "" && amount == "0" && ( !UIHelper.isStringAnInt(stringNumber: amount) || !UIHelper.isStringADecimalNumber(stringNumber: amount))){
                                UIHelper.showErrorMessage("Please enter a number")
                            }}
                        )
                    
                    Text("Choose Convert Base Rate Currency:")
                    
                    Picker(selection: $model.selectedCurrency, label: Text("Base Currency")) {
                        ForEach(0 ..< (model.dict.count)) {
                            Text("\(model.dict.allKeys[$0] as! String)").tag($0)
                        }
                        
                    }
                }
                
                HStack {
                    Button(action: {
                        if (amount == "" && amount == "0" && ( !UIHelper.isStringAnInt(stringNumber: amount) || !UIHelper.isStringADecimalNumber(stringNumber: amount))){
                            UIHelper.showErrorMessage("Please enter a number")
                        }else{
                            allrates = goToCalculate(amount: amount, frombaseCurrency: model.dict.allKeys[model.selectedCurrency] as! String)
                            if (allrates.count>0){
                                rate = allrates[0]
                            }
                        }
                        
                    } ) { Text("Calculate") }}
                    if (allrates.count>0){
                        let columns = [
                                GridItem(.fixed(100)),
                                GridItem(.fixed(100))
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
                    rateArray.append(answer)
            }
        }
        
        }
        
        return rateArray
    }
    
   
    
    
}

#Preview {
    CurrencyView(model: Currency())
}
