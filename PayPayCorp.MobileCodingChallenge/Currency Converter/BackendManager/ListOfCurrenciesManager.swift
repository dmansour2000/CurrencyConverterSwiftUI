//
//  ListOfCurrenciesManager.swift
//  PayPayCorp.MobileCodingChallenge
//
//  Created by Dina Mansour  on 27/12/2023.
//

import Alamofire
import RxAlamofire
import RxSwift
import RxCocoa
import Foundation


class ListofCurrenciesManager {
    
    
    let status = Session(configuration: .ephemeral)
    static var sharedManager = ListofCurrenciesManager()
    
    fileprivate init() {}
    
    func listOfCurrencies() -> Observable<CurrenciesModel>{
        
        let url = NSURL(string: Constants.API_BASE_URL + Constants.CURRENCIES + Constants.APP_ID )!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        
      
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.rx.json(request: request as URLRequest)
            .map {
                if var model = $0 as? JSONDictionary{
                    
                    
                    let result = $0 as! NSDictionary
                   
                    let model = CurrenciesModel.init(result: result)
                   
                    return model
                }else{
                    let model = CurrenciesModel.init(result: [:])
                    
                    return model
                }
                
        }
        // .catchErrorJustReturn(.error(.server))
        
        
        
        
    }
    
    
    
    
}


