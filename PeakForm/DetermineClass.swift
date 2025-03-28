//
//  DetermineClass.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/27/25.
//

import Foundation

func determineClass(powerLevel: Int) -> String {
    switch powerLevel {
    case 300...:
        return "Class S"
    case 200..<300:
        return "Class A"
    case 100..<200:
        return "Class B"
    default:
        return "Class C"
    }
}
