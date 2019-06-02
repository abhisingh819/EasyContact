//
//  ContactDetailViewModel.swift
//  EasyContact
//
//  Created by Abhinav Singh on 6/2/19.
//  Copyright © 2019 Abhinav. All rights reserved.
//

import Foundation

class ContactDetailViewModel {
    
    let api = APIContacts()
    
    func getContactDetailFromAPI(_ url:String, completionHandler:@escaping (Bool,ContactDetail?) -> Void){
        
        api.getContactDetail(url, parameters: nil){(data:AnyObject?,error:NSError?) in
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
    
    func deleteContact(_ url:String, completionHandler:@escaping (Bool,ContactDetail?) -> Void){
        
        
        api.deleteContact(url){(data:AnyObject?,error:NSError?) in
            if error == nil {
                completionHandler(true, nil)
                
            }else {
                completionHandler(false,nil)
            }
        }
    }
    
}
