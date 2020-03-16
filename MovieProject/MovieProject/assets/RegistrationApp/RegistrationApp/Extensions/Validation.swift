//
//  Regex.swift
//  RegistrationApp
//
//  Created by asmaaashraf on 7/11/19.
//  Copyright © 2019 ThirdDoploma. All rights reserved.
//

import Foundation
import UIKit

//    REGEX FUNCTION FOR E-MAIL
func isValidEmailAddress(emailAddressString: String) -> Bool {
    
    var returnValue = true
    let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    
    do {
        let regex = try NSRegularExpression(pattern: emailRegEx)
        let nsString = emailAddressString as NSString
        let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
        
        if results.count == 0
        {
            returnValue = false
        }
        
    } catch let error as NSError {
        print("invalid regex: \(error.localizedDescription)")
        returnValue = false
    }
    
    return  returnValue
}

func isValidPassword (passwordString: String!) -> Bool {
    let value = true
    if passwordString.count > 8 {
        return value
    } else {
        return value == false
    }
    return value
}
