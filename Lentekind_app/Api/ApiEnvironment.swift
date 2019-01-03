//
//  ApiEnvironment.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 28/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation

enum ApiEnvironment: String { case
    
    production = "http://projecten3studserver03.westeurope.cloudapp.azure.com:3002"
    
    var url:String {
        return rawValue
    }
}
