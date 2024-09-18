//
//  passwordManagerApp.swift
//  passwordManager
//
//  Created by Tharik on 17/09/24.
//

import SwiftUI

@main
struct passwordManagerApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}
