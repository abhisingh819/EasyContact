//
//  APIContacts.swift
//  EasyContact
//
//  Created by Abhinav Singh on 6/1/19.
//  Copyright © 2019 Abhinav. All rights reserved.
//

import Foundation

class APIContacts:NSObject{
    
    let BASE_URL = "http://gojek-contacts-app.herokuapp.com/"
    /**
     getContacts
     
     - parameter completionHandler:        (AnyObject response, NSError)
     */
    func getContacts(_ parameters:[String:AnyObject]?,_ completionHandler:@escaping ((AnyObject?,NSError?)->Void)){
        
        APIHelper.makeRequest(urlString: "\(BASE_URL)contacts.json", verb: .GET, parameters: nil, headers: nil,type:"JSON",completionHandler: completionHandler)
        
    }
    
}
