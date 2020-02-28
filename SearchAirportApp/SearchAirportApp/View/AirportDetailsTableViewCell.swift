//
//  AirportDetailsTableViewCell.swift
//  SearchAirportApp
//
//  Created by Dileep Nair on 2/25/20.
//  Copyright © 2020 Dileep Sanker. All rights reserved.
//

import UIKit

class AirportDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var runwayLengthLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var airportNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func configure(_ modelObj: AirportViewModel) {
        self.airportNameLabel.text =  modelObj.airportName
        self.countryLabel.text = modelObj.countryName
        self.runwayLengthLabel.text = modelObj.runwayLength
        self.cityLabel.text = modelObj.cityName
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
}

extension AirportDetailsTableViewCell {
    static func getCellIdentifier() -> String{
       return String(describing: self)
    }
}
