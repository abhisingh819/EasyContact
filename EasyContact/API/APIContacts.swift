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
     getFacilities
     
     - parameter completionHandler:        (AnyObject response, NSError)
     */
    func getContacts(_ parameters:[String:AnyObject]?,_ completionHandler:@escaping ((AnyObject?,NSError?)->Void)){
        
        APIHelper.makeRequest(urlString: "https://my-json-server.typicode.com/iranjith4/ad-assignment/db", verb: .GET, parameters: nil, headers: nil,type:"JSON",completionHandler: completionHandler)
        
    }
    
}
