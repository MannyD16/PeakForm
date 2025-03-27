//
//  PlayerProfile+CoreDataProperties.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/27/25.
//
//

import Foundation
import CoreData


extension PlayerProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerProfile> {
        return NSFetchRequest<PlayerProfile>(entityName: "PlayerProfile")
    }

    @NSManaged public var username: String?
    @NSManaged public var powerLevel: Int64
    @NSManaged public var damage: Int64
    @NSManaged public var characterClass: String?
    @NSManaged public var weapon: String?
    @NSManaged public var headwear: String?
    @NSManaged public var pants: String?
    @NSManaged public var shoes: String?

}

extension PlayerProfile : Identifiable {

}
