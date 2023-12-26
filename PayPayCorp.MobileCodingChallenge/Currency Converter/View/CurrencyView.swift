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
    @ObservedObject var model = Currency()
    
    var body: some View {
        
        if (model.dict.count > 0){
            VStack{
                HStack {
                    Text("Enter Amount in USD:")
                    TextField("Amount", text: $amount)
                        .keyboardType(.numberPad)
                        .onReceive(Just(amount), perform: { newValue in
                            if (amount == "" || !UIHelper.isStringAnInt(stringNumber: amount)){
                                UIHelper.showErrorMessage("Please enter a number without decimals")
                            }}
                        )
                    
                    Text("Choose Convert Rate Currency:")
                    
                    Picker(selection: $model.selectedCurrency, label: Text("Base Currency")) {
                        ForEach(0 ..< (model.dict.count)) {
                            Text("\(model.dict.allKeys[$0] as! String)").tag($0)
                        }
                         
                    }
                }
                
            HStack {
                    Button(action: {
                        rate = goToCalculate(amount: self.amount)
                        
                    } ) { Text("Calculate") }
                    if (rate != 0.0){ (Text(String(rate))) }
                }
            }
            
        }
    }
    
    func  goToCalculate(amount: String) -> Double{
        var rate = 1.0
        if ((model.dict.count)>0){
            rate = (model.dict.allValues[model.selectedCurrency] as? Double)!
        }
        var answer: Double = 0.0
        if (amount != "" && UIHelper.isStringAnInt(stringNumber: amount)){
            var newBase = Double(amount)!
            answer = newBase * rate
        }
        
        return answer
    }
    
   
    
    
}

#Preview {
    CurrencyView(model: Currency())
}
