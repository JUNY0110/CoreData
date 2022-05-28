//
//  eeeeeApp.swift
//  eeeee
//
//  Created by 지준용 on 2022/05/27.
//

import SwiftUI

@main
struct CoreDataTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
