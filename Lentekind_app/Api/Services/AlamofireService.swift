//
//  AlamofireService.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 28/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

//source: https://www.raywenderlich.com/35-alamofire-tutorial-getting-started
//source: https://medium.com/hyphe/realm-and-alamofire-in-effective-harmony-6aba9fb29391

class AlamofireService {
    
    
    let keyChain:KeychainWrapper = KeychainWrapper(serviceName: "Lentekind", accessGroup: "All")
    
    init(context: ApiContext = PersistentApiContext()) {
        self.context = context

    }
    
    
    var context: ApiContext
    
    
    func get(at route: ApiRoute, params: Parameters? = nil) -> DataRequest {
        return request(
            at: route,
            method: .get,
            params: params,
            encoding: URLEncoding.default)
    }
    
    func post(at route: ApiRoute, params: Parameters? = nil) -> DataRequest {
        return request(
            at: route,
            method: .post,
            params: params,
            encoding: JSONEncoding.default)
    }
    
    func put(at route: ApiRoute, params: Parameters? = nil) -> DataRequest {
        return request(
            at: route,
            method: .put,
            params: params,
            encoding: JSONEncoding.default)
    }
    
    func delete(at route: ApiRoute, params: Parameters? = nil) -> DataRequest {
        return request(
            at: route,
            method: .delete,
            params: params,
            encoding: JSONEncoding.default)
    }
    
    
    func request(at route: ApiRoute, method: HTTPMethod, params: Parameters?, encoding: ParameterEncoding) -> DataRequest {
        let url = route.url(for: "http://projecten3studserver03.westeurope.cloudapp.azure.com:3002")
        let headers:HTTPHeaders = ["Authorization": keyChain.string(forKey: "Token") ?? "none"]
        print(keyChain.string(forKey: "Token") ?? "none")
        return Alamofire.request(
            url,
            method: method,
            parameters: params,
            encoding: encoding,
            headers: headers)
            .validate()
    }
}
