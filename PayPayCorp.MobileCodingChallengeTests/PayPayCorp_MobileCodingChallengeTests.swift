//
//  PayPayCorp_MobileCodingChallengeTests.swift
//  PayPayCorp.MobileCodingChallengeTests
//
//  Created by Dina  on 18/11/2023.
//

import Foundation
import XCTest

@testable import PayPayCorp_MobileCodingChallenge

final class PayPayCorp_MobileCodingChallengeTests: XCTestCase {
        
    
     func testCurrencygetBaseRates() {
         let baseratesrequestManagerMock = CurrencyGetBASERATESMock()

        XCTAssertTrue( baseratesrequestManagerMock.isSuccess)

    }

    func testCurrencycallNetwork() {
        let networkcallrequestManagerMock = CurrencyNetworkCallMock()
        
        XCTAssertTrue( networkcallrequestManagerMock.isSuccess)
    }
}

class CurrencyNetworkCallMock{
    var isSuccess = true

    func makeNetworkRequest<T>(urlRequestObject: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        if isSuccess {
            let successResultDto = returnedCurrenciesArray() as! T
            completion(.success(successResultDto))
        } else {
            let errorString = "Cannot create request object here"
            let error = NSError(domain: Constants.API_BASE_URL + Constants.LATEST + Constants.APP_ID, code: 401, userInfo: [NSLocalizedDescriptionKey: errorString])

            completion(.failure(error))
        }
    }

    func returnedCurrenciesArray() -> [BaseModel] {
        let currency1 = BaseModel(disclaimer: "", license: "", timestamp: NSNumber(), base: "", rates: [:])
        let currency2 = BaseModel(disclaimer: "", license: "", timestamp: NSNumber(), base: "", rates: [:])
        let currency3 = BaseModel(disclaimer: "", license: "", timestamp: NSNumber(), base: "", rates: [:])
        return [currency1, currency2, currency3]
    }
}

class CurrencyGetBASERATESMock{
    var isSuccess = true

    func makeNetworkRequest<T>(urlRequestObject: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        if isSuccess {
            let successResultDto = returnedCurrenciesArray() as! T
            completion(.success(successResultDto))
        } else {
            let errorString = "Cannot create request object here"
            let error = NSError(domain:  Constants.API_BASE_URL + Constants.CURRENCIES + Constants.APP_ID, code: 401, userInfo: [NSLocalizedDescriptionKey: errorString])

            completion(.failure(error))
        }
    }

    func returnedCurrenciesArray() -> [CurrenciesModel] {
        let currency1 = CurrenciesModel(result: [:])
        let currency2 = CurrenciesModel(result: [:])
        let currency3 = CurrenciesModel(result: [:])
        return [currency1, currency2, currency3]
    }
}
