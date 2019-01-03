//
//  User.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 28/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation
import ObjectMapper

struct User:Mappable{
    var _id:String = ""
    var email:String = ""
    var firstname:String = ""
    var lastname:String = ""
    var telNr:String = ""
    var rights:Int = -1
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        _id <- map["id"]
        email <- map["email"]
        firstname <- map["firstname"]
        lastname <- map["lastname"]
        telNr <- map["telNr"]
        rights <- map["rights"]
    }
}
