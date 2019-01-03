//
//  ApiContext.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 28/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation

protocol ApiContext: class {
    var environment: ApiEnvironment { get set}
}
