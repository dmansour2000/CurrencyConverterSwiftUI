//
//  ContentView.swift
//  PayPayCorp.MobileCodingChallenge
//
//  Created by Dina Mansour on 18/11/2023.
//

import SwiftUI

struct CurrencyView: View {
    @State private var selection: String = " "
    @State private var amount: String = "0.0"
    @State private var rate: Double = 0.0
    @State private var selectedCurrency: Int = 0
    @ObservedObject var model = Currency()
    
    var body: some View {
        
        if (model.dict.count ?? 0>0){
            VStack{
            HStack {
                Text("Enter Amount:")
                TextField("Amount", text: $amount)
                Text("Choose Base Rate Currency:")
                Picker("Base Currency", selection: $selection) {
                    ForEach(0 ..< (model.dict.count ?? 0)) {
                        Text("\(model.dict.allKeys[$0] as! String)").tag(selectedCurrency)
                    }
                }.pickerStyle(MenuPickerStyle())
                    .onChange(of: selection, perform: {newValue in ForEach(0 ..< (model.dict.count ?? 0)) {newValue in
                        Text("\(model.dict.allKeys[newValue] as! String)").tag(selectedCurrency)
                        
                    }})
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
            rate = (model.dict.allValues[selectedCurrency] as? Double)!
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
