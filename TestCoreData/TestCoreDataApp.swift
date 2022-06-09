//
//  TestCoreDataApp.swift
//  TestCoreData
//
//  Created by 지준용 on 2022/06/09.
//

import SwiftUI

@main
struct TestCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
