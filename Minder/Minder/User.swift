//
//  User.swift
//  Minder
//
//  Created by Ahmed Moalim on 7/15/17.
//  Copyright © 2017 Minder. All rights reserved.
//

import Foundation.NSURL

// Query service creates Track objects
class User {
    
    let fname: String
    let email: String
    let username: String
    let password: String
    let photo: URL
    let age: Int
    let occupation: String
    let education: String
    let status: Int
    
    init(_ fname: String, _ email: String, _ username: String, _ password: String, _ photo: URL, _ age: Int, _ occupation: String, _ education: String, _ status: Int) {
        self.fname = fname
        self.email = email
        self.username = username
        self.password = password
        self.photo = photo
        self.age = age
        self.occupation = occupation
        self.education = education
        self.status = status
    }
}
