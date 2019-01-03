//
//  ApiUser.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 28/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//
import ObjectMapper
import Foundation

class ApiUser: UserProtocol, Mappable {
    
    required public init?(map:Map) {}
    
    var _id: String = ""
    
    var firstname: String = ""
    
    var lastname: String = ""
    
    func mapping(map:Map) {
        _id <- map["_id"]
        firstname <- map["firstname"]
        lastname <- map[""]
    }
}
