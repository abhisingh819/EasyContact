//
//  EditContactViewModel.swift
//  EasyContact
//
//  Created by Abhinav Singh on 6/2/19.
//  Copyright © 2019 Abhinav. All rights reserved.
//

import Foundation

class EditContactViewModel {
    
    let api = APIContacts()
    
    func addContact(_ parameter:[String:AnyObject], completionHandler:@escaping (Bool,ContactDetail?) -> Void){
        
        
        api.addContact(parameter){(data:AnyObject?,error:NSError?) in
            if error == nil {
                if let jsonData = data as? [String:AnyObject] {
                    var contact = ContactDetail()
                    contact = ContactDetail.mapJSONToModel(json: jsonData)
                    completionHandler(true,contact)
                }
                
            }else {
                completionHandler(false,nil)
            }
        }
    }
    
    func updateContact(_ url:String, parameter:[String:AnyObject], completionHandler:@escaping (Bool,ContactDetail?) -> Void){
        
        
        api.updateContact(url,parameters: parameter){(data:AnyObject?,error:NSError?) in
            if error == nil {
                if let jsonData = data as? [String:AnyObject] {
                    var contact = ContactDetail()
                    contact = ContactDetail.mapJSONToModel(json: jsonData)
                    completionHandler(true,contact)
                }
                
            }else {
                completionHandler(false,nil)
            }
        }
    }
    
}
