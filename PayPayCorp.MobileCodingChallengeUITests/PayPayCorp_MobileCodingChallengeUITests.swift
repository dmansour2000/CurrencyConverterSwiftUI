//
//  PayPayCorp_MobileCodingChallengeUITests.swift
//  PayPayCorp.MobileCodingChallengeUITests
//
//  Created by Dina  on 18/11/2023.
//

import XCTest
import Foundation

final class PayPayCorp_MobileCodingChallengeUITests: XCTestCase {

    func testCurrencyView() {
        // 1
        let app = XCUIApplication()
       // setupSnapshot(app)
        app.launch()
        // 2
        let amountTextField = app.textFields["Amount"]
        amountTextField.tap()
        amountTextField.typeText("10")
        // 3
        let currencyPicker = app.pickers.firstMatch
        //currencyPicker.waitForExistence(timeout: 15)
        //currencyPicker.tap()
      
        // 5
        let grid = app.grids.firstMatch
        //grid.waitForExistence(timeout: 15)
        //grid.tap()
    }

   
}
