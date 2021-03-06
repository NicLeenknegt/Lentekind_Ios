//
//  PersistentApiContext.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 28/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation

class PersistentApiContext:ApiContext {
    
    init(environment:ApiEnvironment = ApiEnvironment.production) {
        self.environment = environment
    }
    
    var environment: ApiEnvironment
    
}
