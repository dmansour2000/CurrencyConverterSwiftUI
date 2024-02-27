//
//  ListOfCurrenciesViewModel.swift
//  PayPayCorp.MobileCodingChallenge
//
//  Created by Dina Mansour  on 27/12/2023.
//

import RxSwift
import RxCocoa


struct ListofCurrenciesReducer {
    

    func listOfCurrencies()-> Observable<CurrenciesStore>  {
        return ListofCurrenciesManager.sharedManager.listOfCurrencies()
    }
    
    
}
