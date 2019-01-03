//
//  RegisterReq.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 28/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation

struct RegisterReq:Codable {
    var firstname:String
    var lastname:String
    var email:String
    var password:String
    var telNr:String
    var rights:Int
}
