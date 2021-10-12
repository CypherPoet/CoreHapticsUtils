// AHAPPattern+PatternElement+Event.swift
//
// Created by CypherPoet.
// ✌️
//
    
import Foundation
import CoreHaptics


fileprivate typealias PatternElement = AHAPPattern.PatternElement
fileprivate typealias Event = PatternElement.Event


extension PatternElement {
    
    public struct Event: Codable {
        public let time: TimeInterval?
        public let eventType: EventType?
        public let eventDuration: TimeInterval?
        public let eventParameters: [EventParameter]?
        
        enum CodingKeys: CHHapticPattern.Key.RawValue, CodingKey {
            case time = "Time"
            case eventType = "EventType"
            case eventDuration = "EventDuration"
            case eventParameters = "EventParameters"
        }
    }
}


// MARK: - EventType
extension Event {
    
    public enum EventType: CHHapticPattern.Key.RawValue, Codable {
        case hapticContinuous = "HapticContinuous"
        case hapticTransient = "HapticTransient"
    }
}


// MARK: - EventParameter
extension Event {

    public struct EventParameter: Codable {
        public let parameterID: AHAPPattern.EventParameterID?
        public let parameterValue: Double?
        
        enum CodingKeys: CHHapticPattern.Key.RawValue, CodingKey {
            case parameterID = "ParameterID"
            case parameterValue = "ParameterValue"
        }
    }
}
