//
//  Message.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 30/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation
import ObjectMapper

struct Message:Mappable {
    var message:String = ""
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        message <- map["message"]
    }
}
