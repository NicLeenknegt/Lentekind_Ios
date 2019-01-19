//
//  AfAdminService.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 02/01/2019.
//  Copyright © 2019 Nicolaas Leenknegt. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import CodableFirebase
import ObjectMapper
import RealmSwift

class AfAdminService: AlamofireService, AdminService {
    
    let formatter = DateFormatTransform()
    
    func getParents(completion: @escaping ParentResult) {
        get(at: .getParents())
            .responseArray {
                (res:DataResponse<[Parent]>) in
                completion(res.result.value ?? [], res.result.error)
        }
    }
    
    func setParentPaid(parent_Id:String, date:Date, completion: @escaping MessageResult) {
        put(at: .setParentPaid(parent_id: parent_Id), params: ["date":formatter.transformToJSON(date) ?? Date()] as [String:Any])
            .responseObject {
                (res:DataResponse<Message>) in
                completion(res.result.value, res.result.error)
        }
    }
    
    func setParentUnPaid(parent_Id:String, date:Date, completion: @escaping MessageResult) {
        put(at: .setParentUnPaid(parent_id: parent_Id), params: ["date":formatter.transformToJSON(date) ?? Date()] as [String:Any])
            .responseObject {
                (res:DataResponse<Message>) in
                completion(res.result.value, res.result.error)
        }
    }
    
}
