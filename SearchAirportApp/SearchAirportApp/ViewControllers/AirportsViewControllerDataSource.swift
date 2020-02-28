//
//  AirportsViewControllerDataSource.swift
//  SearchAirportApp
//
//  Created by Dileep Nair on 2/25/20.
//  Copyright © 2020 Dileep Sanker. All rights reserved.
//

import UIKit

class AirportsViewControllerDataSource: NSObject{
    public var airportItems = [AirportModel]()
}

extension AirportsViewControllerDataSource: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airportItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = AirportListTableViewCell.getCellIdentifier()
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! AirportListTableViewCell
        let airportViewModel = AirportViewModel(airport: airportItems[indexPath.row])
        cell.configure(airportViewModel)
        return cell
        
    }
}
