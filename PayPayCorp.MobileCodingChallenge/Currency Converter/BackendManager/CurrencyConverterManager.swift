//
//  
//
//
//  Created by Dina Mansour on 10/5/18.
//  Copyright © 2018 TestApplication. All rights reserved.
//

import Alamofire
import RxAlamofire
import RxSwift
import RxCocoa
import Foundation


enum AutenticationError: Error {
    case server
    case badReponse
    case badCredentials
}

enum AutenticationStatus {
    case none
    case error(AutenticationError)
    case user(String)
}

typealias JSONDictionary = [String: Any]



class CurrencyConverterManager {
    
    
    let status = Session(configuration: .ephemeral)
    static var sharedManager = CurrencyConverterManager()
    
    fileprivate init() {}
    
    func currencyConverter() -> Observable<BaseModel>{
        
        let url = NSURL(string: Constants.API_BASE_URL )!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        
      
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.rx.json(request: request as URLRequest)
            .map {
                if var model = $0 as? JSONDictionary{
                    
                    
                    let success = model["success"] as! Bool
                    let timestamp = model["timestamp"] as! NSNumber
                    let base = model["base"] as! String
                    let date = model["date"] as! String
                    let rates = model["rates"] as! NSDictionary
                   
                      let model = BaseModel.init(success: success, timestamp: timestamp, base: base, date: date, rates: rates)
                   
                    return model
                }else{
                    let model = BaseModel.init(success: false, timestamp: 0, base: "", date: "", rates: [:])
                    
                    return model
                }
                
        }
        // .catchErrorJustReturn(.error(.server))
        
        
        
        
    }
    
    
    
    
}

