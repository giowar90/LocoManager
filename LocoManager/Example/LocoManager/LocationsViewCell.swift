//
//  LocationsViewCell.swift
//  LocoManager_Example
//
//  Created by Gio Guerra on 16/08/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

class LocationsViewCell: UITableViewCell {
    
    static let identifierCell = "cell_location"
    
    @IBOutlet weak var latitud_label: UILabel!
    @IBOutlet weak var longitud_label: UILabel!
    @IBOutlet weak var date_label: UILabel!
    @IBOutlet weak var content_view: UIView! {
        didSet {
            content_view.layer.cornerRadius = 20
            content_view.layer.borderColor = UIColor.black.cgColor
            content_view.layer.borderWidth = 1
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configData(model: LocationCoreData) {
        latitud_label.text = "Latitud: \(model.latitude)"
        longitud_label.text = "Longitud: \(model.longitude)"
        date_label.text = "Fecha: \(model.date)"
    }
    
}
