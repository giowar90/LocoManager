//
//  LocationsViewController.swift
//  LocoManager_Example
//
//  Created by Gio Guerra on 16/08/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

class LocationsViewController: UIViewController {
    
    @IBOutlet weak var locations_table: UITableView! {
        didSet {
            locations_table.dataSource = self
            locations_table.delegate = self
            locations_table.separatorStyle = UITableViewCell.SeparatorStyle.none
            locations_table.backgroundColor = .clear
            locations_table.cellLayoutMarginsFollowReadableWidth = true
            locations_table.allowsSelection = true
            locations_table.rowHeight = 80
        }
    }
    
    var locationsData: [LocationCoreData] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        locationsData = DBManager.share.getLocations()
        setupTableView()
        navigateBar()
    }
    
    @IBAction func delete_action(_ sender: Any) {
        DBManager.share.deleteAllData()
        locationsData = DBManager.share.getLocations()
        locations_table.reloadData()
    }

    private func setupTableView() {
        locations_table.register(UINib(nibName: "LocationsViewCell", bundle: nil), forCellReuseIdentifier: LocationsViewCell.identifierCell)
    }
    
    func navigateBar() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.black
            navigationController?.navigationBar.standardAppearance = appearance;
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        }
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.backItem?.backButtonTitle = "Atrás"
    }

}

extension LocationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationsViewCell.identifierCell, for: indexPath) as? LocationsViewCell else {
            return UITableViewCell()
        }
        let model = locationsData[indexPath.row]
        cell.configData(model: model)
        return cell
    }
    
    
}
