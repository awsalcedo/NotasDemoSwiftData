//
//  NotasDemoSwiftDataApp.swift
//  NotasDemoSwiftData
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 19/9/24.
//

import SwiftUI
import SwiftData

@main
struct NotasDemoSwiftDataApp: App {
    /*
     Esta configuración la hace Xcode directamente al marcar el check
     de SwiftData cuando se crea el proyecto
     */
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Note.self, Category.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
