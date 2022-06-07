//
//  LearningCoreDataApp.swift
//  LearningCoreData
//
//  Created by 지준용 on 2022/06/07.
//

import SwiftUI

@main
struct LearningCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
