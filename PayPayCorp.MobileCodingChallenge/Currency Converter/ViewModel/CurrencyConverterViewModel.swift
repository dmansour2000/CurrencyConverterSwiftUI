//
//  
//
//
//  Created by Dina Mansour on 10/5/18.
//  Copyright © 2018 TestApplication. All rights reserved.
//

import RxSwift
import RxCocoa


struct CurrencyConverterViewModel {
    

    
    
    
    func currencyConverter()-> Observable<BaseModel>  {
        return CurrencyConverterManager.sharedManager.currencyConverter()
    }
    
    
}
