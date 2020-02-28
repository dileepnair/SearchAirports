//
//  Array+Extension.swift
//  SearchAirportApp
//
//  Created by Dileep Nair on 2/26/20.
//  Copyright © 2020 Dileep Sanker. All rights reserved.
//

import Foundation
import CoreLocation

extension Array {
    func first(elementCount: Int) -> Array {
          let min = Swift.min(elementCount, count)
          return Array(self[0..<min])
    }
}

extension Array where Element == AirportModel {
    func sorted(by location: CLLocation) -> [AirportModel] {
        return sorted(by: { $0.location.distance(from: location) < $1.location.distance(from: location) })
    }
}
