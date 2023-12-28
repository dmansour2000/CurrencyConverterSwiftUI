//
//  Constants.swift
//
//
//  Created by Dina Mansour on 9/2/19.
//  Copyright © 2019 Dina Mansour. All rights reserved.
//

import UIKit

public class Constants: NSObject {
    
    
    static let API_BASE_URL = "https://openexchangerates.org/api"
    
    static let APP_ID = "?app_id=d0686b9b71144c40a4a1c37d7ee2a151"
    
    static let LATEST = "/latest.json"
    
    static let CURRENCIES = "/currencies.json"
    
    
    struct CustomNavBarTags {
        static let BiggerNavBar: Int = 8989
        static let NormalNavBar: Int = 8181
        static let TitleLabel: Int = 9898
        static let BiggerTitleLabel: Int = 7878
        static let BackButton: Int = 6767
    }
    
    
    
    static let DEBUG_RESPONSE = true
    
    static let REQUEST_LIMIT = "50"
    
    static let CONTENT_TYPE = "application/json"
    
    
    public static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}



