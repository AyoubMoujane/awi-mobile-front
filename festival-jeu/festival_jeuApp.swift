//
//  festival_jeuApp.swift
//  festival-jeu
//
//  Created by ayoub moujane on 23/03/2021.
//

import SwiftUI

@main
struct festival_jeuApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
