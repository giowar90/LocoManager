//
//  ViewController.swift
//  LocoManager
//
//  Created by Giovanni Guerra on 08/14/2023.
//  Copyright (c) 2023 Giovanni Guerra. All rights reserved.
//

import UIKit
import LocoManager
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tracking_btn: UIButton! {
        didSet {
            tracking_btn.layer.cornerRadius = 15
            if UserDefaults.standard.bool(forKey: "Tracking"){
                ManagerLocation.share.startupdateLocation()
                icon = UIImage(named: "location_off_icon")
                textBtn = "Desactivar tracking"
                tracking_btn.isSelected = true
            }else{
                ManagerLocation.share.stopLocation()
                icon = UIImage(named: "location_on_icon")
                textBtn = "Activar tracking"
                tracking_btn.isSelected = false
            }
            tracking_btn.setImage(icon, for: .normal)
            tracking_btn.setTitle(textBtn, for: .normal)
        }
    }
    @IBOutlet weak var locations_btn: UIButton! {
        didSet {
            locations_btn.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var map_view: MKMapView! {
        didSet {
            map_view.showsUserLocation = true
        }
    }
    
    var icon = UIImage(named: "location_off_icon")
    var textBtn: String = "Activar tracking"

    override func viewDidLoad() {
        super.viewDidLoad()
        ManagerLocation.share.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tracking_action(_ sender: Any) {
        if tracking_btn.isSelected {
            ManagerLocation.share.stopLocation()
            icon = UIImage(named: "location_on_icon")
            textBtn = "Activar tracking"
            UserDefaults.standard.set(false, forKey: "Tracking")
        }else{
            ManagerLocation.share.startupdateLocation()
            icon = UIImage(named: "location_off_icon")
            textBtn = "Desactivar tracking"
            UserDefaults.standard.set(true, forKey: "Tracking")
        }
        tracking_btn.isSelected = !tracking_btn.isSelected
        tracking_btn.setImage(icon, for: .normal)
        tracking_btn.setTitle(textBtn, for: .normal)
    }
    
    @IBAction func locations_action(_ sender: Any) {
        let controller = LocationsViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension ViewController: ManagerLocationDelegate {
    func getLocation(location: CLLocation) {
        if UserDefaults.standard.bool(forKey: "Tracking"){
            DBManager.share.saveLocations(
                latitude: location.coordinate.latitude,
                Longitude: location.coordinate.longitude)
        }
    }
}

