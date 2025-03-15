//
//  HealthManager.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/14/25.
//

import HealthKit

class HealthManager {
    static let shared = HealthManager()
    private let healthStore = HKHealthStore()

    // HealthKit Data Types We Need
    private let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!

    // Request Permission
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let allTypes = Set([calorieType])

        healthStore.requestAuthorization(toShare: [], read: allTypes) { success, error in
            completion(success, error)
        }
    }

    // Fetch Calories Burned
    func fetchCaloriesBurned(completion: @escaping (Double) -> Void) {
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: calorieType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let sum = result?.sumQuantity() else {
                completion(0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.kilocalorie()))
        }

        healthStore.execute(query)
    }
}
