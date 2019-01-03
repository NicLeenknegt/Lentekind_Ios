//
//  ChildContainer.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 29/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation
import ObjectMapper

struct ChildContainer:Mappable {
    var _id:String = ""
    var child:Child = Child()
    
    init?(map:Map) {}
    
    mutating func mapping(map: Map) {
        _id <- map["_id"]
        child <- map["child"]
    }
}
