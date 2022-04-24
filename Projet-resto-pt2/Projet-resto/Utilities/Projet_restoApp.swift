//
//  Projet_restoApp.swift
//  Projet-resto
//
//  Created by user213684 on 3/25/22.
//

import SwiftUI

@main
struct Projet_restoApp: App {
    // instancier notre dataController
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
