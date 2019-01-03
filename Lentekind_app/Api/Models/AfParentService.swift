//
//  AfParentService.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 29/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import CodableFirebase
import ObjectMapper
import RealmSwift

//source https://stackoverflow.com/questions/32846922/how-to-remove-a-key-value-pair-from-swift-dictionary
//source https://stackoverflow.com/questions/30480672/how-to-convert-a-json-string-to-a-dictionary

class AfParentService:AlamofireService, parentService {
    
    private var realm:Realm { return try! Realm() }
    
    func getChildren(completion: @escaping ChildrenResult) {
        get(at: .getChildren(_id: getUser()._id))
            .responseArray {
                (res: DataResponse<[ChildContainer]>) in
                completion(res.result.value ?? [], res.result.error)
        }
    }
    
    
    func updateChild(child:Child, completion: @escaping MessageResult) {
        print("1")
        guard let json = Mapper().toJSONString(child) else { return }
        guard let data = json.data(using: String.Encoding.utf8) else { return }
        do {
            let dict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
            put(at: .updateChild(), params: dict)
                .responseObject {
                    (res:DataResponse<Message>) in
                    completion(res.result.value, res.result.error)
            }
        } catch {
            print("Something went wrong")
        }
        
    }
    
    func setDateOfChild(child_id:String, dateObjects:[DateObject] ,completion: @escaping MessageResult) {
        var dictArray:[[String:Any]] = [[String:Any]]()
        
        do {
            try dateObjects.forEach { obj in
                guard let json = Mapper().toJSONString(obj) else { return }
                guard let data = json.data(using: String.Encoding.utf8) else { return }
                
                let dict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                if let dict = dict {
                   dictArray.append(dict)
                }
            }
            
        } catch {
            print("Something went wrong.")
        }
        put(at: .setDateOfChild(child_id: child_id), params: ["ios":dictArray])
            .responseObject {
                (res:DataResponse<Message>) in
                completion(res.result.value, res.result.error)
        }
    }
    
    func addChild(child: Child, completion: @escaping MessageResult) {
        guard let json = Mapper().toJSONString(child) else { return }
        guard let data = json.data(using: String.Encoding.utf8) else { return }
        do {
            var dict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
            dict?.removeValue(forKey: "_id")
            post(at: .addChild(_id: getUser()._id), params: dict)
                .responseObject {
                    (res:DataResponse<Message>) in
                    completion(res.result.value, res.result.error)
            }
        } catch {
            print("something went wrong")
        }
    }
    
    
    private func getUser() -> User {
        let rlmUser = realm.objects(RealmUser.self)[0]
        return rlmUser.getUser()
    }
}
