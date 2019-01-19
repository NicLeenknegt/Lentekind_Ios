//
//  AdminService.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 02/01/2019.
//  Copyright © 2019 Nicolaas Leenknegt. All rights reserved.
//

import Foundation

typealias ParentResult = (_ parent:[Parent], _ error:Error?) -> ()

protocol AdminService {
    func getParents(completion: @escaping ParentResult)
    
    func setParentPaid(parent_Id:String, date:Date, completion: @escaping MessageResult)
    
    func setParentUnPaid(parent_Id:String, date:Date, completion: @escaping MessageResult)
}
