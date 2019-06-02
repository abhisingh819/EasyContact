//
//  Validation.swift
//  EasyContact
//
//  Created by Abhinav Singh on 6/2/19.
//  Copyright © 2019 Abhinav. All rights reserved.
//

import Foundation

class Validation {
    
    /**
     Validate an email: Based on a third party regex
     
     - parameter email: the email to validate
     - returns: true for valid and false for invalid
     */
    class func emailValidationError(_ email:String?) -> (Bool) {
        if let nonNilEmail = email {
            let validEmailRegex = NSLocalizedString("^((([a-zA-Z]|\\d|[!#\\$%&'\\*\\+\\-\\/=\\?\\^_`{\\|}~]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])+(\\.([a-zA-Z]|\\d|[!#\\$%&'\\*\\+\\-\\/=\\?\\^_`{\\|}~]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])+)*)|((\\x22)((((\\x20|\\x09)*(\\x0d\\x0a))?(\\x20|\\x09)+)?(([\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x7f]|\\x21|[\\x23-\\x5b]|[\\x5d-\\x7e]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(\\\\([\\x01-\\x09\\x0b\\x0c\\x0d-\\x7f]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF]))))*(((\\x20|\\x09)*(\\x0d\\x0a))?(\\x20|\\x09)+)?(\\x22)))@((([a-zA-Z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(([a-zA-Z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])([a-zA-Z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])*([a-zA-Z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])))\\.)+(([a-zA-Z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(([a-zA-Z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])([a-zA-Z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])*([a-zA-Z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])))$", comment:"Any Comment") //
            if let _ = nonNilEmail.range(of: validEmailRegex, options: .regularExpression){
                return true
            }
        }
        return false
    }
    
    /**
     Validate an email: Based on a third party regex
     
     - parameter email: the email to validate
     - returns: true for valid and false for invalid
     */
    
    class func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    /**
     Validate password with the following rules:
     1. at least 8 chars (no upper limit)
     2. at least 1 number
     3. at least 1 lower case letter
     4. at least 1 upper case letter
     
     - parameter password: the password to validate
     - returns: true for valid and false for invalid
     */
    class func passwordValidationError(_ password:String?) -> (Bool) {
        if let nonNilPassword = password {
            let validPasswordRegex = NSLocalizedString("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$", comment:"Any Comment") //
            if let _ = nonNilPassword.range(of: validPasswordRegex, options: .regularExpression){
                return true
            }
        }
        return false
    }
    
    
    /**
     Test if the supplied text contains non white space characters
     
     - parameter text: the input text to test
     
     - returns: Bool
     */
    class func containsNonWhiteSpaceCharacters(_ text:String) -> Bool {
        let nonWhiteSpaceCharactersRegex = NSLocalizedString("[\\S]", comment:"Any Comment")
        if let _ = text.range(of: nonWhiteSpaceCharactersRegex, options: .regularExpression){
            return true
        }
        return false
    }
    
    /**
     Test if the supplied text contains only digits or numbers
     
     - parameter text: the input text to test
     
     - returns: Bool
     */
    class func containsNumbersOnly(_ text:String) -> Bool {
        let numberRegex = NSLocalizedString("^[0-9]+$", comment:"Any Comment")
        if let _ = text.range(of: numberRegex, options: .regularExpression){
            return true
        }
        return false
    }
    
}
