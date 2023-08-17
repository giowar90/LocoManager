//
//  LocationViewModel.swift
//  LocoManager_Example
//
//  Created by Gio Guerra on 16/08/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

struct LocationCoreData {
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var date: String = ""

    init(){}
    init(latitude: Double, longitude: Double, date: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
    }
}
