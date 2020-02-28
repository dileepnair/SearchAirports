//
//  ListAirportsEndpoint.swift
//  SearchAirportApp
//
//  Created by Dileep Nair on 2/25/20.
//  Copyright © 2020 Dileep Sanker. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum AirportsAPI {
    case airportList
}

extension AirportsAPI: EndPointType {
    
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production, .staging, .qa: return "https://gist.githubusercontent.com/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        return "tdreyno/4278655/raw/7b0762c09b519f40397e4c3e100b097d861f5588/airports.json"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var task: HTTPTask {
        return .request
    }
    
}
