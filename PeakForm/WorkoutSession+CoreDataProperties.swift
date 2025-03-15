//
//  WorkoutSession+CoreDataProperties.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/14/25.
//
//

import Foundation
import CoreData


extension WorkoutSession {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutSession> {
        return NSFetchRequest<WorkoutSession>(entityName: "WorkoutSession")
    }

    @NSManaged public var caloriesBurned: Int64
    @NSManaged public var date: Date?
    @NSManaged public var duration: Int64
    @NSManaged public var exerciseType: String?
    @NSManaged public var id: UUID?

}

extension WorkoutSession : Identifiable {

}
