//
//  PersonalInfoEntity+CoreDataProperties.swift
//  CoreDataTest
//
//  Created by 지준용 on 2022/05/30.
//
//

import Foundation
import CoreData


extension PersonalInfoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonalInfoEntity> {
        return NSFetchRequest<PersonalInfoEntity>(entityName: "PersonalInfoEntity")
    }

    @NSManaged public var bloodType: String?
    @NSManaged public var date: Date?
    @NSManaged public var emergencyContact: String?
    @NSManaged public var medicalRecord: String?
    @NSManaged public var medicineRecord: String?
    @NSManaged public var name: String?
    @NSManaged public var photoImage: Data?
    @NSManaged public var spareContact: String?

}

extension PersonalInfoEntity : Identifiable {

}
