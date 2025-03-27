//
//  PeakFormApp.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/27/25.
//

import SwiftUI

@main
struct PeakFormApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
