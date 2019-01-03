//
//  ParentService.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 29/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation

typealias ChildrenResult = (_ children:[ChildContainer], _ error:Error?) -> ()
typealias MessageResult = (_ message:Message?, _ error:Error?) -> ()

protocol parentService {
    func getChildren(completion: @escaping ChildrenResult)
    
    func updateChild(child:Child, completion: @escaping MessageResult)
    
    func addChild(child:Child, completion: @escaping MessageResult)
    
    func setDateOfChild(child_id:String, dateObjects:[DateObject], completion: @escaping MessageResult)
}
