//
//  DateObject.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 29/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation
import ObjectMapper

struct DateObject:Mappable, Equatable {
    var date:Date = Date()
    var time:String = ""
    
    init() {}
    
    init(date: Date, time:String) {
        self.date = date
        self.time = time
    }
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        date <- (map["date"], DateFormatTransform())
        time <- map["time"]
    }
    
    static func ==(lhs: DateObject, rhs: DateObject) -> Bool {
        return lhs.date == rhs.date && lhs.time == rhs.time
    }
}
