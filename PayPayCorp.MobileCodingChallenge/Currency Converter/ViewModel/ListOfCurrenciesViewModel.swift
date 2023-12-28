//
//  ListOfCurrenciesViewModel.swift
//  PayPayCorp.MobileCodingChallenge
//
//  Created by Dina Mansour  on 27/12/2023.
//

import RxSwift
import RxCocoa


struct ListofCurrenciesViewModel {
    

    func listOfCurrencies()-> Observable<CurrenciesModel>  {
        return ListofCurrenciesManager.sharedManager.listOfCurrencies()
    }
    
    
}
