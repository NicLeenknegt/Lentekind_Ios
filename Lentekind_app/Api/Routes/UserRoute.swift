//
//  UserRoute.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 28/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation

enum ApiRoute { case
    
    login(email:String, password:String),
    register(),
    getChildren(_id:String),
    updateChild(),
    setDateOfChild(child_id:String),
    addChild(_id:String),
    getParents()
    
    
    var path: String {
        switch self {
        case .login(let _, let _):return "/API/users/login"
        case .register(): return "/API/users/register"
        case .getChildren(let _id): return "/API/parent/\(_id)"
        case .updateChild(): return "/API/parent/children"
        case .setDateOfChild(let _id): return "/API/parent/dates/\(_id)/ios"
        case .addChild(let _id): return "/API/parent/\(_id)/children"
        case .getParents(): return "/API/admin/parents"
        }
    }
    
    func url(for environment:String) -> String {
        return "\(environment)\(path)"
    }
}
