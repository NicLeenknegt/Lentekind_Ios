//
//  ParentDetailDelegate.swift
//  Lentekind_app
//
//  Created by Nic Leenknegt on 19/01/2019.
//  Copyright © 2019 Nicolaas Leenknegt. All rights reserved.
//

import Foundation

protocol ParentDetailDelegate {
    func setParentPaid(date:Date)
    func setParentUnPaid(date:Date)
    
}
