//
//  AirportModel.swift
//  SearchAirportApp
//
//  Created by Dileep Nair on 2/25/20.
//  Copyright © 2020 Dileep Sanker. All rights reserved.
//

import Foundation
import CoreLocation

struct AirportApiResponse {
    let airports: [AirportModel]?
}

extension AirportApiResponse: Decodable {
    
    private enum AirportApiResponseCodingKeys: String, CodingKey {
        case airports
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AirportApiResponseCodingKeys.self)
        airports = try container.decode([AirportModel].self, forKey: .airports)
    }
}


struct AirportModel {
   let city: String?
   let code: String?
   let state: String?
   let country: String?
   let lat: Double?
   let long: Double?
   let name: String?
   let runwayLength: String?
}

extension AirportModel: Decodable {
    enum AirportCodingKeys: String, CodingKey {
        case city
        case code
        case state
        case country
        case lat
        case long
        case name
        case runwayLength = "runway_length"
    }
    
    init(from decoder: Decoder) throws {
        let airportContainer = try decoder.container(keyedBy: AirportCodingKeys.self)
        city = try airportContainer.decode(String.self, forKey: .city)
        code = try airportContainer.decode(String.self, forKey: .code)
        state = try airportContainer.decode(String.self, forKey: .state)
        country = try airportContainer.decode(String.self, forKey: .country)
        lat = try Double(airportContainer.decode(Double.self, forKey: .lat))
        long = try Double(airportContainer.decode(Double.self, forKey: .long))
        name = try airportContainer.decode(String.self, forKey: .name)
        runwayLength = try airportContainer.decode(String.self, forKey: .runwayLength)
    }
}

extension AirportModel {
    var location: CLLocation {
        return CLLocation(latitude: self.lat!, longitude: self.long!)
    }
    
    func distance(to location: CLLocation) -> CLLocationDistance {
        return location.distance(from: self.location)
    }
}


