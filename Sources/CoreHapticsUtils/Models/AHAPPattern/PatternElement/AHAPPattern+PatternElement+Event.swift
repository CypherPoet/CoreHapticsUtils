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
        public let eventWaveformPath: String?
        public let eventWaveformShouldUseVolumeEnvelope: Bool?
        public let eventParameters: [EventParameter]?
        

        enum CodingKeys: CHHapticPattern.Key.RawValue, CodingKey {
            case time = "Time"
            case eventType = "EventType"
            case eventDuration = "EventDuration"
            case eventWaveformPath = "EventWaveformPath"
            
            /// For events of type `CHHapticEventTypeAudioCustom`, this indicates
            /// whether the audio file playback should be ramped in and out with an envelope.
            ///
            /// This can be useful for preventing clicks during playback, or for
            /// cases where the application wants to modulate this envelope
            /// to use different attack and release times.
            ///
            /// Value type: `Bool`.
            /// Default: `true`
            case eventWaveformShouldUseVolumeEnvelope = "EventWaveformUseVolumeEnvelope"
            
            case eventParameters = "EventParameters"
        }
    }
}


// MARK: - EventType
extension Event {
    
    public enum EventType: CHHapticPattern.Key.RawValue, Codable {
        case hapticContinuous = "HapticContinuous"
        case hapticTransient = "HapticTransient"
        case audioContinuous = "AudioContinuous"
        case audioCustom = "AudioCustom"
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
