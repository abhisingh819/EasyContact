//
//  APIContacts.swift
//  EasyContact
//
//  Created by Abhinav Singh on 6/1/19.
//  Copyright © 2019 Abhinav. All rights reserved.
//

import Foundation

class APIContacts:NSObject{
    
    /**
     getContacts
     
     - parameter completionHandler:        (AnyObject response, NSError)
     */
    func getContacts(_ parameters:[String:AnyObject]?,_ completionHandler:@escaping ((AnyObject?,NSError?)->Void)){
        
        APIHelper.makeRequest(urlString: "\(Constants.CONTACTS)", verb: .GET, parameters: nil, headers: nil,type:"JSON",completionHandler: completionHandler)
        
    }
    
    /**
     getContactDetail
     
     - parameter url:                      (String)
     - parameter completionHandler:        (AnyObject response, NSError)
     */
    func getContactDetail(_ url:String, parameters:[String:AnyObject]?,_ completionHandler:@escaping ((AnyObject?,NSError?)->Void)){
        
        APIHelper.makeRequest(urlString: url, verb: .GET, parameters: nil, headers: nil,type:"JSON",completionHandler: completionHandler)
        
    }
    
}
