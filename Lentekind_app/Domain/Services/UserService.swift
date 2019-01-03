//
//  UserService.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 28/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation

typealias UserResult = (_ user:User? , _ error:Error?) -> ()

protocol userService {
    func login(email:String, password:String, completion: @escaping UserResult)
    
    func register(req:RegisterReq, completion: @escaping UserResult)
    
}
