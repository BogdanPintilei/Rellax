//
//  APIClientFact.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/18/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import Foundation
import Alamofire

extension APIClient {
    
    static func getFacts(exerciseID: Int, completion: @escaping(Result<[Fact]>) -> Void) {
        let path = "tracks/\(exerciseID)/facts"
        get(path: path) { (result) in
            completion(result.result)
        }
    }
    
}
