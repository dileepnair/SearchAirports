//
//  AirportListViewController.swift
//  SearchAirportApp
//
//  Created by Dileep Nair on 2/25/20.
//  Copyright © 2020 Dileep Sanker. All rights reserved.
//

import UIKit
import CoreLocation

class AirportListViewController: UIViewController {
   
    @IBOutlet weak var airportTableView: UITableView!
    let tableViewDataSource = AirportsViewControllerDataSource()
    var resultSearchController = UISearchController()
    var filteredData: [AirportModel]!

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var airports: [AirportModel]! = [] {
           didSet {
               tableViewDataSource.airportItems = self.airports
               DispatchQueue.main.async{
                   self.airportTableView.reloadData()
               }
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.topItem?.title = "Airports"
        self.searchBar.isUserInteractionEnabled = false
        self.configureTableView()
        self.populateAirportList()
        filteredData = airports
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
    }
    
    // MARK: - ViewController: Private methods -
    private func showErrorMessageAlert() {
        let alert = UIAlertController(title: "Alert",
                                      message: "Invalid service response. Please contact administrator.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .cancel,
                                      handler: {(_: UIAlertAction!) in
                                        //Sign out action
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func populateAirportList(){
        AirportViewModel.getAirportsList{[weak self] airports, success in
            if !success {
                DispatchQueue.main.async {
                    self?.showErrorMessageAlert()
                    self?.activityIndicator.stopAnimating()
                    self?.searchBar.isUserInteractionEnabled = true
                }
            }
            guard let airportsList = airports else {
                return
            }
            let sortedAirportCities = airportsList.sorted(by: { (($0 as AirportModel).city as String?) ?? "" < (($1 as AirportModel).city as String?) ?? "" })
            self?.airports = sortedAirportCities
            DispatchQueue.main.async{
                self?.activityIndicator.stopAnimating()
                self?.searchBar.isUserInteractionEnabled = true
            }
        }
    }
    
    private func refreshSearchList() {
        tableViewDataSource.airportItems = self.filteredData
        DispatchQueue.main.async{
            self.airportTableView.reloadData()
        }
    }
    
    private func configureTableView() {
        airportTableView.dataSource = tableViewDataSource
        airportTableView.delegate = self
        DispatchQueue.main.async {
            self.airportTableView.setNeedsLayout()
            self.airportTableView.layoutIfNeeded()
        }
    }
    
}

// MARK: - ViewController: UITableViewDelegate -

extension AirportListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAirportWithCity = !filteredData.isEmpty ? filteredData[indexPath.row] : airports[indexPath.row]
        guard !selectedAirportWithCity.city!.isEmpty else {
            airportTableView.deselectRow(at: indexPath, animated: true)
            return
        }
        let selectedCityLocation = CLLocation(latitude: selectedAirportWithCity.lat!, longitude: selectedAirportWithCity.long!)
        _ = AirportDetailsViewModel.init(selectedCityLocation: selectedCityLocation)
        let airportDetailsViewController = UIStoryboard.init(name: "Main",
                                               bundle: Bundle.main).instantiateViewController(withIdentifier: "AirportDetailsViewController") as? AirportDetailsViewController
        airportDetailsViewController?.currentSelectedLocation = selectedCityLocation
        self.navigationController?.pushViewController(airportDetailsViewController!, animated: true)
        airportTableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - ViewController: UISearchBarDelegate -

extension AirportListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData = searchText.isEmpty ? airports : airports.filter { (item: AirportModel) -> Bool in
            return item.city!.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        self.refreshSearchList()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}
