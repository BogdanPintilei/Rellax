//
//  APIClientFact.swift
//  Mindfulness
//
//  Created by Bogdan Pintilei on 7/18/18.
//  Copyright © 2018 Wolfpack. All rights reserved.
//

import Foundation
import Alamofire

extension APIClient {
    
    static func getFacts(exerciseID: Int, completion: @escaping(Result<[Fact]>) -> Void) {
        let path = "exercises/\(exerciseID)/facts"
        get(path: path) { (result) in
            completion(result.result)
        }
    }
    
}
