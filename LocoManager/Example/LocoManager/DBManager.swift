//
//  DBManager.swift
//  LocoManager_Example
//
//  Created by Gio Guerra on 16/08/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DBManager: NSObject {
    
    static let share = DBManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveLocations(latitude: Double, Longitude: Double) {
        let entity = NSEntityDescription.entity(forEntityName: "LocationsData", in: context)!
        let locationObjet = NSManagedObject(entity: entity, insertInto: context)
        locationObjet.setValue(latitude, forKey: "latitude")
        locationObjet.setValue(Longitude, forKey: "Longitude")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let stringDate = dateFormatter.string(from: Date())
        locationObjet.setValue(stringDate, forKey: "date")
        
        do {
            try context.save()
        } catch let error {
            print("some one error----\(error.localizedDescription)")
        }
    }
    
    func getNSManaged() -> [NSManagedObject] {
        var managedObject: [NSManagedObject] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LocationsData")
        do {
            managedObject = try context.fetch(fetchRequest)
            return managedObject
        } catch let error {
            print("someOne error ---\(error.localizedDescription)")
        }
        return []
    }
    
    func getLocations() -> [LocationCoreData]{
        let managedObject = getNSManaged()
        var locationsData: [LocationCoreData] = []
        var fillLongitude: Double?
        var fillLatitude: Double?
        var fillDate: String?
        
        for dbObject in managedObject {
            if let longitudeDb = dbObject.value(forKey: "longitude") as? Double {
                fillLongitude = longitudeDb
            }
            if let latitudeeDb = dbObject.value(forKey: "latitude") as? Double {
                fillLatitude = latitudeeDb
            }
            if let dateDb = dbObject.value(forKey: "date") as? String {
                fillDate = dateDb
            }
            
            let locationData = LocationCoreData(
                latitude: fillLatitude!,
                longitude: fillLongitude!,
                date: fillDate!)
            locationsData.append(locationData)
        }
        return locationsData
    }
    
    func deleteAllData(){
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: "LocationsData")
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do { try context.execute(DelAllReqVar) }
        catch { print(error) }
    }
    
}
