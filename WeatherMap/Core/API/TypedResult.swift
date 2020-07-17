//
//  TypedResult.swift
//  WeatherMap
//
//  Created by Matias Bzurovski on 17/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

enum TypedResult<T> {
    case success(T)
    case error(Error)
}
