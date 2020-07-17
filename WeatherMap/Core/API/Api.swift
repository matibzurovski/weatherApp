//
//  Api.swift
//  WeatherMap
//
//  Created by Matias Bzurovski on 17/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Api {
    
    func fetchWeather(requestObject: WeatherRequestObject, completion: @escaping (TypedResult<WeatherResponse>) -> Void) {
        let url = ApiConfiguration.baseUrl + "/onecall"
        let parameters = requestObject.parameters
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).validate().responseJSON { response in
            guard let data = response.data, let json = try? JSON(data: data) else {
                completion(TypedResult.error(CustomError(description: "Unexpected response without data")))
                return
            }
            switch response.result {
            case .success:
                let result = WeatherResponse(json: json)
                completion(.success(result))
            case .failure(let error):
                completion(.error(error))
            }
        }
    }
}
