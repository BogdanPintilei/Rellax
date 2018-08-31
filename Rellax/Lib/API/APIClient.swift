//
//  APIClient.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/17/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import Alamofire

class APIClient {

    static func get<T: Decodable> (
        path: String,
        params: [String: Any]? = nil,
        completion: @escaping (DataResponse<T>) -> Void) {
        performRequest(path: path, method: .get, params: params, completion: completion)
    }

    // MARK: Private

    private static func performRequest<T: Decodable>(
        path: String,
        method: HTTPMethod,
        params: [String: Any]?,
        completion: @escaping(DataResponse<T>) -> Void) {

        let requestParams = params ?? [String: Any]()
        let headers: HTTPHeaders = ["token": SessionManager.deviceToken]

        Alamofire.request (
            url(from: path),
            method: method,
            parameters: requestParams,
            headers: headers).validate().responseJSONDecodable { (response: DataResponse<T>) in
            completion(response)    
        }
    }

    private static func url(from string: String) -> String {
        return "https://rellax.herokuapp.com/api/v1/" + string
    }

}

