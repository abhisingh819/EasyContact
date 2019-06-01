//
//  ContactDetail.swift
//  EasyContact
//
//  Created by Abhinav Singh on 6/1/19.
//  Copyright © 2019 Abhinav. All rights reserved.
//

import Foundation

class ContactDetail {
    var contactId:String?
    var firstName: String?
    var lastName:String?
    var email:String?
    var phoneNumber: String?
    var profilePic:String?
    var favorite:Bool?
    var createdTime:String?
    var updatedTime:String?
    
    static func mapJSONToModel(json:[String:AnyObject]) -> ContactDetail {
        let contact = ContactDetail()
        if let contactId = json["id"] as? String {
            contact.contactId = contactId
        }
        if let email = json["email"] as? String {
            contact.email = email
        }
        if let phoneNumber = json["phone_number"] as? String {
            contact.phoneNumber = phoneNumber
        }
        if let firstName = json["first_name"] as? String {
            contact.firstName = firstName
        }
        if let lastName = json["last_name"] as? String {
            contact.lastName = lastName
        }
        if let profilePic = json["profile_pic"] as? String {
            contact.profilePic = profilePic
        }
        if let favorite = json["favorite"] as? Bool {
            contact.favorite = favorite
        }
        if let createdTime = json["created_at"] as? String {
            contact.createdTime = createdTime
        }
        if let updatedTime = json["updated_at"] as? String {
            contact.updatedTime = updatedTime
        }
        
        return contact
    }
    
    
}
