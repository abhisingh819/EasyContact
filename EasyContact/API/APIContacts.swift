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
    
    /**
     addContact
     
     - parameter completionHandler:        (AnyObject response, NSError)
     */
    func addContact(_ parameters:[String:AnyObject],_ completionHandler:@escaping ((AnyObject?,NSError?)->Void)){
        
        APIHelper.makeRequest(urlString: "\(Constants.CONTACTS)", verb: .POST, parameters: parameters, headers: nil,type:"JSON",completionHandler: completionHandler)
        
    }
    
    /**
     updateContact
     
     - parameter url:                      (String)
     - parameter completionHandler:        (AnyObject response, NSError)
     */
    func updateContact(_ url:String, parameters:[String:AnyObject],_ completionHandler:@escaping ((AnyObject?,NSError?)->Void)){
        
        APIHelper.makeRequest(urlString: url, verb: .PUT, parameters: parameters, headers: nil,type:"JSON",completionHandler: completionHandler)
        
    }
    
    /**
     deleteContact
     
     - parameter url:                      (String)
     - parameter completionHandler:        (AnyObject response, NSError)
     */
    func deleteContact(_ url:String,_ completionHandler:@escaping ((AnyObject?,NSError?)->Void)){
        
        APIHelper.makeRequest(urlString: url, verb: .DELETE, parameters: nil, headers: nil,type:"JSON",completionHandler: completionHandler)
        
    }
    
}
