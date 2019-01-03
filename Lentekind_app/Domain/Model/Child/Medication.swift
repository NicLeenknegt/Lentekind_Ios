//
//  Medication.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 29/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation
import ObjectMapper

struct Medication:Mappable,Equatable {
    var name:String = ""
    var note:String = ""
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        note <- map["note"]
    }
    
    static func ==(lhs: Medication, rhs: Medication) -> Bool {
        return lhs.name == rhs.name && lhs.note == rhs.note
    }
}
