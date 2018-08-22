//
//  APIClientExercise.swift
//  Mindfulness
//
//  Created by Bogdan Pintilei on 7/18/18.
//  Copyright © 2018 Wolfpack. All rights reserved.
//

import Foundation
import Alamofire

extension APIClient {

    static func getExerciseList(completion: @escaping(Result<[Exercise]>) -> Void) {
        let path = "exercises"
        get(path: path) { (result) in
            completion(result.result)
        }
    }

}
