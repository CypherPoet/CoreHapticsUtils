// HapticsPerformer.swift
//
// Created by CypherPoet.
// ✌️
//
    
import Foundation
import CoreHaptics
import CoreHapticsUtils


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


extension HapticsPerformer.Error: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .engineCreationFailed(error: _):
            return "\(self)"
        case .engineStartFailed(error: _):
            return "\(self)"
        case .engineFailedToPlayPatternFromFile(fileURL: _, error: _):
            return "\(self)"
        case .engineFailedToPlayPatternFromData(data: _, error: _):
            return "\(self)"
        case .engineFailedToStop(error: _):
            return "\(self)"
        case .playerFailedToPause(error: _):
            return "\(self)"
        case .unknownError(_):
            return "\(self)"
        case .playerFailedToStop(error: let error):
            return "\(self)"
        }
    }
}
