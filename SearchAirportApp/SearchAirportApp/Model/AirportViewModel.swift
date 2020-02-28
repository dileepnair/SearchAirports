//
//  AirportViewModel.swift
//  SearchAirportApp
//
//  Created by Dileep Nair on 2/25/20.
//  Copyright © 2020 Dileep Sanker. All rights reserved.
//

import Foundation

struct AirportViewModel {
    var airport: AirportModel
}

extension AirportViewModel {
    var cityName: String {
        return "\(airport.city ?? "New York")"
    }
    var countryName: String {
        return "\(airport.country ?? "US")"
    }
    
    var runwayLength: String {
        return "\(airport.runwayLength ?? "2131212")"
    }
    
    var airportName: String {
        return "\(airport.name ?? "San Francisco International")"
    }
}

extension AirportViewModel {
    static func getAirportsList(_ completionHandler: @escaping (_ airportArr:[AirportModel]?,_ success: Bool)->() ){
        let networkManager = NetworkManager()
        networkManager.getAirportList(completion: { airports, error in
            var airportModelArr = [AirportModel]()
            guard let airports = airports else{
                completionHandler(nil, false)
                return
            }
            for airport in airports{
                let airportObj =  airport as! [String:Any]
                let latitudeString = airportObj["lat"] as! String
                let longitudeString = airportObj["lon"] as! String
                let latitude = Double(latitudeString)
                let longitude = Double(longitudeString)
                let airportModelObj = AirportModel(city: airportObj["city"] as? String,
                                                   code: airportObj["code"] as? String,
                                                   state: airportObj["state"] as? String,
                                                   country: airportObj["country"] as? String,
                                                   lat: latitude,
                                                   long: longitude,
                                                   name: airportObj["name"] as? String,
                                                   runwayLength: airportObj["runway_length"] as? String)
                airportModelArr.append(airportModelObj)
            }
            completionHandler(airportModelArr, true)
        })
    }
}
