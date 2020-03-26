//
//  APIClientExercise.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/18/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import Foundation
import Alamofire

extension APIClient {

    static func getExerciseList(completion: @escaping(Result<[Track]>) -> Void) {
        let path = "tracks"
        get(path: path) { (result) in
            completion(result.result)
        }
    }

}
