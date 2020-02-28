//
//  AirportsDetailsViewDataSource.swift
//  SearchAirportApp
//
//  Created by Dileep Nair on 2/26/20.
//  Copyright © 2020 Dileep Sanker. All rights reserved.
//

import UIKit

class AirportsDetailsViewDataSource: NSObject{
    public var airportDetailItems = [AirportModel]()
}

extension AirportsDetailsViewDataSource: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        airportDetailItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = AirportDetailsTableViewCell.getCellIdentifier()
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! AirportDetailsTableViewCell
        let airportViewModel = AirportViewModel(airport: airportDetailItems[indexPath.row])
        cell.configure(airportViewModel)
        return cell
    }
    

}
