//
//  AirportDetailsViewController.swift
//  SearchAirportApp
//
//  Created by Dileep Nair on 2/25/20.
//  Copyright © 2020 Dileep Sanker. All rights reserved.
//

import UIKit
import CoreLocation

let NEARBY_AIRPORTS_COUNT = 5

class AirportDetailsViewController: UIViewController {
    @IBOutlet weak var airportDetailsTableView: UITableView!
    let tableViewDataSource = AirportsDetailsViewDataSource()
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var currentSelectedLocation: CLLocation?
    var selectedAirport: [AirportModel]! = [] {
        didSet {
            tableViewDataSource.airportDetailItems = self.selectedAirport
            DispatchQueue.main.async{
                self.airportDetailsTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureTableView()
        self.populateNearestAirportDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
    }
    
    // MARK: - ViewController: Private methods -
    
    private func configureTableView() {
        airportDetailsTableView.dataSource = tableViewDataSource
        airportDetailsTableView.delegate = self
        DispatchQueue.main.async {
            self.airportDetailsTableView.setNeedsLayout()
            self.airportDetailsTableView.layoutIfNeeded()
        }
    }
    
    private func populateNearestAirportDetails() {
        AirportViewModel.getAirportsList{[weak self] airports, success in
            guard let airportsList = airports else {
                return
            }
            if let selectedCityLocation = self?.currentSelectedLocation {
                let closestAirports = airportsList.sorted(by: selectedCityLocation).first(elementCount: NEARBY_AIRPORTS_COUNT)
                self?.selectedAirport = closestAirports
                DispatchQueue.main.async{
                    self?.activityIndicatorView.stopAnimating()
                }
            }
        }
    }
}

extension AirportDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        airportDetailsTableView.deselectRow(at: indexPath, animated: true)
    }
}
