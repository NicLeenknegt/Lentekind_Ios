//
//  RealmUser.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 29/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation
import RealmSwift
class RealmUser:Object {
    
    @objc dynamic var _id:String = ""
    @objc dynamic var email:String = ""
    @objc dynamic var firstname:String = ""
    @objc dynamic var lastname:String = ""
    @objc dynamic var telNr:String = ""
    @objc dynamic var rights:Int = 0
    
    convenience required init(copy obj:User) {
        self.init()
        self._id = obj._id
        self.email = obj.email
        self.firstname = obj.firstname
        self.lastname = obj.lastname
        self.telNr = obj.telNr
        self.rights = obj.rights
    }
    
    override class func primaryKey() -> String? {
        return "_id"
    }
    
    func getUser() -> User {
        
        var user = User()
        user._id = _id
        user.email = email
        user.firstname = firstname
        user.lastname = lastname
        user.rights = rights
        user.telNr = telNr
        
        return user
    }
}
