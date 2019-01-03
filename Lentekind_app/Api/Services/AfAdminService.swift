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
    
    
    func getParents(completion: @escaping ParentResult) {
        get(at: .getParents())
            .responseArray {
                (res:DataResponse<[Parent]>) in
                completion(res.result.value ?? [], res.result.error)
        }
    }
    
    
}
