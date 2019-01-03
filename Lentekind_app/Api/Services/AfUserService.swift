//
//  AfUserService.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 28/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import CodableFirebase
import RealmSwift

class AfUserService: AlamofireService, userService {
    
    private var realm: Realm { return try! Realm() }
    
    func login(email: String, password: String, completion: @escaping UserResult) {
        print("FILEURL")
        print(realm.configuration.fileURL)
        let dict: [String: Any] = try! FirestoreEncoder().encode(LoginReq(email:email, password:password))
        post(at: .login(email: email, password: password), params: dict)
            .responseObject {
                (res:DataResponse<User>) in
                self.persist(res.result.value)
                completion(res.result.value, res.result.error)
        }
    }
    
    func register(req: RegisterReq, completion: @escaping UserResult) {
        let dict: [String:Any] = try! FirestoreEncoder().encode(req)
        post(at: .register(), params: dict)
            .responseObject {
                (res:DataResponse<User>) in
                self.persist(res.result.value)
                completion(res.result.value, res.result.error)
        }
    }
    
    func getUser() -> User {
        let rlmUser = realm.objects(RealmUser.self)[0]
        return rlmUser.getUser()
    }
    
    private func persist(_ user:User?) {
        guard let user = user else { return }
        let obj = realm.object(ofType: RealmUser.self, forPrimaryKey: user._id)
        if (obj == nil) {
            try! realm.write {
                realm.delete(realm.objects(RealmUser.self))
                realm.add(RealmUser(copy:user), update: true)
            }
        } else {
            try! realm.write {
                realm.add(RealmUser(copy:user), update: true)
            }
        }
        
    }
}
