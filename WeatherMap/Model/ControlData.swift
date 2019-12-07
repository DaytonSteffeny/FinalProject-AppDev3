//
//  ControlData.swift
//  WeatherMap
//
//  Created by Dayton Steffeny on 10/16/19.
//  Copyright © 2019 Dayton Steffeny. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ControlData {
    
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (()->Void)? = nil){
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
    
    static func shared() -> ControlData {
        struct Singleton {
            static var shared = ControlData(modelName: "Weather_Map")
        }
        return Singleton.shared
    }
}
