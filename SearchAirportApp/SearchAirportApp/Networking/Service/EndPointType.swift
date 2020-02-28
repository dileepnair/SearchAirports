//
//  EndPointType.swift
//  SearchAirportApp
//
//  Created by Dileep Nair on 2/25/20.
//  Copyright © 2020 Dileep Sanker. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var task: HTTPTask { get }
}
