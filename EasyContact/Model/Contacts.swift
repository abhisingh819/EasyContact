//
//  Contacts.swift
//  EasyContact
//
//  Created by Abhinav Singh on 6/1/19.
//  Copyright © 2019 Abhinav. All rights reserved.
//

import Foundation


class Contacts {
    var contactId:String?
    var firstName: String?
    var lastName:String?
    var profilePic:String?
    var favorite:Bool?
    var url:String?
    
    static func mapJSONToModel(json:[String:AnyObject]) -> Contacts {
        let contacts = Contacts()
        if let contactId = json["id"] as? String {
            contacts.contactId = contactId
        }
        if let firstName = json["first_name"] as? String {
            contacts.firstName = firstName
        }
        if let lastName = json["last_name"] as? String {
            contacts.lastName = lastName
        }
        if let profilePic = json["profile_pic"] as? String {
            contacts.profilePic = profilePic
        }
        if let favorite = json["favorite"] as? Bool {
            contacts.favorite = favorite
        }
        if let url = json["url"] as? String {
            contacts.url = url
        }
        
        
        return contacts
    }
    
    
}
