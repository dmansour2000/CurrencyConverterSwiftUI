//
//  
//
//
//  Created by Dina Mansour on 10/5/18.
//  Copyright © 2018 TestApplication. All rights reserved.
//

import RxSwift
import RxCocoa


struct CurrencyConverterReducer {
    

    func currencyConverter()-> Observable<BaseStore>  {
        return CurrencyConverterManager.sharedManager.currencyConverter()
    }
    
    
}
