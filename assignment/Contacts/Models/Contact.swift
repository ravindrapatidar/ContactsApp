//
//  Contact.swift
//  Contacts
//
//  Created by Ravindra Patidar on 13/09/19.
//  Copyright © 2019 GoJek. All rights reserved.
//

import Foundation

struct Contact: Decodable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let profilePic: String?
    let favorite: Bool?
    let url: String?
    let phoneNumber: String?
    let email: String?
    
    var fullName: String {
        if firstName == nil && lastName == nil {
            return ""
        } else if firstName == nil {
            return lastName ?? ""
        } else if lastName == nil {
            return firstName ?? ""
        } else {
            return (firstName ?? "")  + " " + (lastName ?? "")
        }
    }
}
