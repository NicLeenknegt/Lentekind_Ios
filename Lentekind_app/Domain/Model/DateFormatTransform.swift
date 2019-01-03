//
//  DateFormatTransform.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 29/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation

import Foundation
import ObjectMapper
public class DateFormatTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    
    var dateFormat = DateFormatter()
    
    init() {
        self.dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        self.dateFormat.timeZone = TimeZone(secondsFromGMT: 0)
        self.dateFormat.locale = Locale(identifier: "en_US_POSIX")
    }
    
    public func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString:String = value as? String {
            if let date = self.dateFormat.date(from: dateString) {
                return date
            }
            return nil
        }
        return nil
    }
    
    public func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return self.dateFormat.string(from: date)
        }
        return nil
    }
}
