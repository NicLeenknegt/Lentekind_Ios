//
//  Child.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 29/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation
import ObjectMapper

struct Child:Mappable, Equatable {
    var _id:String = ""
    var firstname:String = ""
    var lastname:String = ""
    var allergies:String = ""
    var sex:String = ""
    var birthDate:Date = Date()
    var dates:[DateObject] { return _dates }
    var medication:[Medication] { return _medication}

    
    var _medication = [Medication]()
    var _dates = [DateObject]()
    
    init() {}
    init?(map: Map) {}
 
    mutating func mapping(map: Map) {
            print(map["birthdate"].JSON)
        
        _id <- map["_id"]
        firstname <- map["firstname"]
        lastname <- map["lastname"]
        allergies <- map["allergies"]
        sex <- map["sex"]
        birthDate <- (map["birthDate"], DateFormatTransform())
        _dates <- map["dates"]
        _medication <- map["medication"]
        
    }
    
    static func ==(lhs: Child, rhs: Child) -> Bool {
        return
            lhs.firstname == rhs.firstname &&
                lhs.lastname == rhs.lastname &&
                lhs.allergies == rhs.allergies &&
                lhs.sex == rhs.sex &&
                lhs.birthDate == rhs.birthDate &&
                lhs._dates == rhs._dates &&
                lhs._medication == rhs._medication
    }
}
