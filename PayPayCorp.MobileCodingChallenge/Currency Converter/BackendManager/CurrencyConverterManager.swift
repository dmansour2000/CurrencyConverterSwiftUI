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
    
    func currencyConverter() -> Observable<BaseStore>{
        
        let url = NSURL(string: Constants.API_BASE_URL + Constants.LATEST + Constants.APP_ID)!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        
      
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.rx.json(request: request as URLRequest)
            .map {
                if var model = $0 as? JSONDictionary{
                    
                    
                    
                    let disclaimer = model["disclaimer"] as! String
                    let license = model["license"] as! String
                    let base = model["base"] as! String
                    let timestamp = model["timestamp"] as! NSNumber
                    let rates = model["rates"] as! NSDictionary
                   
                    let model = BaseStore.init(disclaimer: disclaimer, license: license, timestamp: timestamp, base: base, rates: rates)
                   
                    return model
                }else{
                    let model = BaseStore.init(disclaimer: "", license: "", timestamp: NSNumber(), base: "", rates: [:])
                    
                    return model
                }
                
        }
        // .catchErrorJustReturn(.error(.server))
        
        
        
        
    }
    
    
    
    
}

