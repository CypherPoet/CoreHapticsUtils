// File.swift
//
// Created by CypherPoet.
// ✌️
//
    

import Foundation
import CoreHaptics


extension CHHapticEngine.StoppedReason {
    
    internal var debugMessage: String {
        switch self {
        case .audioSessionInterrupt:
            return "The audio session was interrupted."
        case .applicationSuspended:
            return "The application was suspended."
        case .idleTimeout:
            return "An idle timeout occurred."
        case .systemError:
            return "A system error occurred."
        case .notifyWhenFinished:
            return "Playback finished."
        case .engineDestroyed:
            return "The engine was destroyed."
        case .gameControllerDisconnect:
            return "The game controller disconnected."
        @unknown default:
            return "Unknown"
        }
    }
}

