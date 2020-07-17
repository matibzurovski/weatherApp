//
//  CustomError.swift
//  WeatherMap
//
//  Created by Matias Bzurovski on 17/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

class CustomError: Error {
    
    fileprivate let description: String
    
    init(description: String) {
        self.description = description
    }
    
    var localizedDescription: String {
        return description
    }
}
