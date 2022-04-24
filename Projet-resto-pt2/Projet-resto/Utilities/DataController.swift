//
//  DataController.swift
//  Projet-resto
//
//  Created by user213684 on 4/10/22.
//

import Foundation

import CoreData
import Foundation

class DataController: ObservableObject {
    // on informe CoreData qu'on veut utiliser ci-dessous
    let container = NSPersistentContainer(name: "Historique")
    
    // on l'initialise
    init() {
        container.loadPersistentStores { description, error in
            // si il y a un probleme a loader le model
            if let error = error {
                print("Core data a planté: \(error.localizedDescription)")
            }
        }
    }
}
