//
//  User.swift
//  inastaBraymok
//
//  Created by admin on 24/11/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

class User  {
    
    var id: String
    var fullName: String
    var email: String
    var password: String
    var profileImagePath: String
    
    static var usersId = [String : String]()
    
    init() {
        self.id = ""
        self.fullName = ""
        self.email = ""
        self.password = ""
        self.profileImagePath = ""
    }
    
    init(id: String,fullname: String,email: String,password: String,profileImage: String) {
        self.id = id
        self.fullName = fullname
        self.email = email
        self.password = password
        self.profileImagePath = profileImage
        
    }
    
    
}
