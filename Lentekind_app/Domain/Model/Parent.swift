//
//  Parent.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 02/01/2019.
//  Copyright © 2019 Nicolaas Leenknegt. All rights reserved.
//

import Foundation
import ObjectMapper

struct Parent:Mappable {
    var _id:String = ""
    var firstname:String = ""
    var lastname:String = ""
    var paidDates:[Date] = [Date]()
    var children:[ChildContainer] = [ChildContainer]()
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        _id <- map["_id"]
        firstname <- map["firstname"]
        lastname <- map["lastname"]
        paidDates <- (map["paidDates"], DateFormatTransform())
        children <- map["children"]
    }
}
