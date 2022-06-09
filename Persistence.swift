//
//  Persistence.swift
//  LearningCoreData
//
//  Created by 지준용 on 2022/06/07.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    // NSPersistentContainer: persistent store coordinator, managed object context, managed object model의 생성을 다룸으로써, 앱의 Core data stack의 생성 및 관리를 단순화한다.
    // 초기화하는 대신 영구저장하는 컨테이너.
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        //
        container = NSPersistentContainer(name: "LearningCoreData")
        if inMemory {
            
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        // persistent container가 초기화되면, persistent stores를 load하고 Core Data stack 생성을 완료하도록 container를 지시하기 위해 loadPersistentStores를 실행해야한다.
        // ladPersistentStore의 completionHandler가 실행하면, stack은 완전히 초기화되고, 사용할 준비가 마쳐진다. completion handler는 생성된 각각의 persistent store에 의해 한 번 호출된다.
        // 만약 persistent store의 loading에 error가 있다면, NSError값이 채워질 것이다.
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
