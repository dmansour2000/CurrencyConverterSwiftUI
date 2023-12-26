//
//  PayPayCorp.MobileCodingChallenge.swift
//  PayPayCorp.MobileCodingChallenge
//
//  Created by Dina Mansour  on 19/11/2023.
//

import SwiftUI
import UIKit
import SideMenu
import DeviceKit


@main
struct PayPayCorpApp: App {
    
    var body: some Scene{
        
        WindowGroup {
            CurrencyView(model: Currency())
        }
    }
}
