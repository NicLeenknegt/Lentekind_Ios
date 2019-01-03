//
//  User.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 28/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation

protocol UserProtocol {
    var _id:String { get }
    var firstname:String { get }
    var lastname:String { get }
    var rights:Int { get }
}
