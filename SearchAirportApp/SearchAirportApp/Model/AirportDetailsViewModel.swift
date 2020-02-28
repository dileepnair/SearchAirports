//
//  AirportDetailsViewModel.swift
//  SearchAirportApp
//
//  Created by Dileep Nair on 2/25/20.
//  Copyright © 2020 Dileep Sanker. All rights reserved.
//

import Foundation
import CoreLocation

struct AirportDetailsViewModel {
    var currentLocation: CLLocation!
    var selectedCityLocation: CLLocation!{
        didSet{
            self.currentLocation = self.selectedCityLocation
        }
    }
}
