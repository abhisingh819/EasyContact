//
//  ContactViewModel.swift
//  EasyContact
//
//  Created by Abhinav Singh on 6/1/19.
//  Copyright © 2019 Abhinav. All rights reserved.
//

import Foundation


class ContactViewModel {

    
    func getContactsFromAPI(_ completionHandler:@escaping (Bool,[Contacts]) -> Void){
        
        let api = APIContacts()
        api.getContacts(nil) {(data:AnyObject?,error:NSError?) in
            if error == nil {
                if let jsonData = data as? [[String:AnyObject]] {
                    var contacts = [Contacts]()
                    for contactJson in jsonData {
                        let contact = Contacts.mapJSONToModel(json: contactJson)
                        contacts.append(contact)
                    }
                    completionHandler(true,contacts)
                }
                
            }else {
                completionHandler(false,[])
            }
        }
    }
    
}
