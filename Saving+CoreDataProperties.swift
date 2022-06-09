//
//  Saving+CoreDataProperties.swift
//  LearningCoreData
//
//  Created by 지준용 on 2022/06/08.
//
//

import Foundation
import CoreData


extension Saving {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Saving> {
        return NSFetchRequest<Saving>(entityName: "Saving")
    }

    @NSManaged public var date: Date?
    @NSManaged public var detail: String?
    @NSManaged public var favorite: Int64
    @NSManaged public var imageD: Data?
    @NSManaged public var name: String?

}

extension Saving : Identifiable {

}
