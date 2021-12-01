// HapticsPerformer.swift
//
// Created by CypherPoet.
// ✌️
//
    
import Foundation
import CoreHaptics


extension HapticsPerformer {
    
    public enum Error: Swift.Error {
        case engineCreationFailed(error: CHHapticError)
        case engineStartFailed(error: CHHapticError)
        
        case engineFailedToPlayPatternFromFile(
            fileURL: URL,
            error: CHHapticError
        )
        
        case engineFailedToPlayPatternFromData(
            data: Data,
            error: CHHapticError
        )

        case engineFailedToStop(error: CHHapticError)

        case playerFailedToPause(error: Swift.Error)
        case playerFailedToStop(error: Swift.Error)

        case unknownError(Swift.Error)
    }
}

//extension HapticsPerformer.Error: Equatable {}
