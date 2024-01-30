//
//  PayPayCorp_MobileCodingChallengeUITests.swift
//  PayPayCorp.MobileCodingChallengeUITests
//
//  Created by Dina  on 18/11/2023.
//

import XCTest
import Foundation

final class PayPayCorp_MobileCodingChallengeUITests: XCTestCase {
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func setUp() {
        super.setUp()
        
        let app = XCUIApplication()
        app.launch()
    }
    
    
    func testLaunch() throws {
        let app = XCUIApplication()
        XCUIDevice.shared.orientation = .portrait
        
        let amountTextField = app.textFields["Amount"]
        amountTextField.tap()
        amountTextField.typeText("10")
       
        let currencyPicker = app.pickerWheels.firstMatch
        if currencyPicker.waitForExistence(timeout: 30){
            currencyPicker.swipeDown()
        }
        
        let grid = app.grids.firstMatch
        if grid.waitForExistence(timeout: 30){
            grid.swipeDown()
        }
    }
    
    
}
