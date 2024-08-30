//
//  CRUDCoreDataApp.swift
//  CRUDCoreData
//
//  Created by Josimar da Cunha Ferreira on 30/08/24.
//

import SwiftUI

@main
struct CRUDCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
