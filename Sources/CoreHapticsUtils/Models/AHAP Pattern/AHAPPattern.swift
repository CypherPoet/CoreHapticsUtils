// AHAPPattern.swift
//
// Created by CypherPoet.
// ✌️
//

import Foundation
import CoreHaptics


public typealias CHHapticPatternDictionary = [CHHapticPattern.Key: Any]

public struct AHAPPattern {
    public var version: Double?
    public var metadata: MetaData?
    public var pattern: [PatternElement]
}


// MARK: - Init
extension AHAPPattern {
    
    public init(
        fileName: String,
        bundle: Bundle = .main
    ) throws {
        guard let fileURL = bundle.url(
            forResource: fileName,
            withExtension: "ahap"
        ) else {
            throw Error.ahapFileNotFound(fileName: fileName)
        }
        
        guard let data = try? Data(contentsOf: fileURL) else {
            throw Error.failedToMakeDataFromFile(fileURL: fileURL)
        }
        
        try self.init(data: data)
    }
    
    
    public init(data: Data) throws {
        let decoder = JSONDecoder()
        
        self = try decoder.decode(Self.self, from: data)
    }
}

extension AHAPPattern: Codable {}


// MARK: -  Error
extension AHAPPattern {
    
    public enum Error: Swift.Error {
        case ahapFileNotFound(fileName: String)
        case failedToMakeDataFromFile(fileURL: URL)
    }
}


// MARK: - Coding Keys
extension AHAPPattern {
    
    enum CodingKeys: CHHapticPattern.Key.RawValue, CodingKey {
        case version = "Version"
        case metadata = "Metadata"
        case pattern = "Pattern"
    }
}


extension AHAPPattern {
    public typealias MetaData = [String: String]
}


extension AHAPPattern {
    
    public struct PatternElement {
        public let event: Event?
        public let dynamicParameter: DynamicParameter?
        public let dynamicParameterCurve: DynamicParameterCurve?
    }
}


// MARK: - Coding Keys
extension AHAPPattern.PatternElement {
    
    enum CodingKeys: CHHapticPattern.Key.RawValue, CodingKey {
        case event = "Event"
        case dynamicParameter = "Parameter"
        case dynamicParameterCurve = "ParameterCurve"
    }
}

extension AHAPPattern.PatternElement: Codable {}



// MARK: -Pattern Element Parameter  Event
extension AHAPPattern.PatternElement {
    
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


// MARK: - AHAPPattern.PatternElement.Event.EventType
extension AHAPPattern.PatternElement.Event {
    
    public enum EventType: CHHapticPattern.Key.RawValue, Codable {
        case hapticContinuous = "HapticContinuous"
        case hapticTransient = "HapticTransient"
    }
}



// MARK: - AHAPPattern.PatternElement.Event.EventParameter
extension AHAPPattern.PatternElement.Event {

    /// An item found in a ``PatternElement.Event.eventParameters`` array.
    ///
    /// [Apple Docs](https://developer.apple.com/documentation/corehaptics/chhapticeventparameter)
    public struct EventParameter: Codable {
        public let parameterID: AHAPPattern.PatternElement.EventParameterID?
        public let parameterValue: Double?
        
        enum CodingKeys: CHHapticPattern.Key.RawValue, CodingKey {
            case parameterID = "ParameterID"
            case parameterValue = "ParameterValue"
        }
    }
}



// MARK: - PatternElement.DynamicParameter
extension AHAPPattern.PatternElement {

    /// A key in the ``AHAPPattern/PatternElement``  dictionary that defines
    /// a [dynamic parameter](https://developer.apple.com/documentation/corehaptics/representing_haptic_patterns_in_ahap_files#3239083).
    ///
    /// Like event parameters, each dynamic parameter has a `ParameterID` string and an
    /// associated value.
    ///
    /// Unlike event parameters, dynamic parameters affect the entire pattern,
    /// across all events.
    ///
    /// ## See Also:
    ///     - https://medium.com/lofelt/core-haptics-in-depth-32f7e03ad46f#:~:text=and%20a%20value.-,Parameters,-In%20addition%20to
    public struct DynamicParameter: Codable {
        public let parameterID: DynamicParameterID?
        public let parameterValue: Double?
        
        enum CodingKeys: CHHapticPattern.Key.RawValue, CodingKey {
            case parameterID = "ParameterID"
            case parameterValue = "ParameterValue"
        }
    }
}



// MARK: - AHAPPattern.PatternElement.DynamicParameterCurve
extension AHAPPattern.PatternElement {
    
    /// A key in the `PatternElement` dictionary that defines a [dynamic
    /// parameter curve](https://developer.apple.com/documentation/corehaptics/chhapticparametercurve).
    public struct DynamicParameterCurve: Codable {
        public let parameterID: DynamicParameterID?
        public let time: TimeInterval?
        public let parameterCurveControlPoints: [ControlPoint]?
        
        enum CodingKeys: CHHapticPattern.Key.RawValue, CodingKey {
            case parameterID = "ParameterID"
            case time = "Time"
            case parameterCurveControlPoints = "ParameterCurveControlPoints"
        }
    }
}



// MARK: - AHAPPattern.PatternElement.ParameterCurve.ControlPoint
extension AHAPPattern.PatternElement.DynamicParameterCurve {
    
    public struct ControlPoint: Codable {
        public let time: TimeInterval?
        public let parameterValue: Double?
        
        enum CodingKeys: CHHapticPattern.Key.RawValue, CodingKey {
            case time = "Time"
            case parameterValue = "ParameterValue"
        }
    }
}



extension AHAPPattern.PatternElement {

    /// An identifier for an event parameter.
    ///
    /// [Apple Docs](https://developer.apple.com/documentation/corehaptics/chhapticevent/parameterid)
    /// [List of Values](https://developer.apple.com/documentation/corehaptics/representing_haptic_patterns_in_ahap_files#:~:text=Specify%20the%20Parameter%20by%20ID)
    public enum EventParameterID: String, Codable {
        
        /// The strength of a haptic event.
        case hapticIntensity = "HapticIntensity"
        
        /// The feel of a haptic event.
        case hapticSharpness = "HapticSharpness"
        
        /// The time at which a haptic pattern’s intensity begins increasing.
        case attackTime = "AttackTime"
        
        /// The time at which a haptic pattern’s intensity begins decreasing.
        case decayTime = "DecayTime"
        
        /// The time at which to begin fading the haptic pattern.
        case releaseTime = "ReleaseTime"
        
        /// A Boolean value that indicates whether to sustain a haptic event for its specified duration.
        case sustained = "Sustained"
        
        /// The volume of an audio event.Audio Event Parameter IDs
        case audioVolume = "AudioVolume"
        
        /// The stereo panning of an audio event.
        case audioPan = "AudioPan"
        
        /// The pitch of an audio event.
        case audioPitch = "AudioPitch"
        
        /// The high-frequency content of an audio event.
        case audioBrightness = "AudioBrightness"
    }
}


extension AHAPPattern.PatternElement {
    
    /// The identifier that reveals the type of property associated with a dynamic parameter.
    ///
    /// [Apple Docs](https://developer.apple.com/documentation/corehaptics/chhapticdynamicparameter/id)
    /// [List of Values](https://developer.apple.com/documentation/corehaptics/representing_haptic_patterns_in_ahap_files#:~:text=maximum%20supported%20value.-,Add%20Dynamic%20Parameters%20to%20Change%20the%20Pattern%20During%20Playback,-Like%20event%20parameters)
    public enum DynamicParameterID: String, Codable {
        /// A dynamic parameter to change the strength of a haptic pattern.
        case hapticIntensityControl = "HapticIntensityControl"
        
        /// A dynamic parameter to change the sharpness of a haptic pattern.
        case hapticSharpnessControl = "HapticSharpnessControl"
        
        /// A dynamic parameter to change the time when a haptic pattern's intensity begins increasing.
        case hapticAttackTimeControl = "HapticAttackTimeControl"
        
        /// A dynamic parameter to change the time when a haptic pattern's intensity begins decreasing.
        case hapticDecayTimeControl = "HapticDecayTimeControl"
        
        /// A dynamic parameter to change the time at which to begin fading the haptic pattern.
        case hapticReleaseTimeControl = "HapticReleaseTimeControl"
        
        /// A dynamic parameter to change the high-frequency content of an audio signal.Audio Dynamic Parameter IDs
        case audioBrightnessControl = "AudioBrightnessControl"
        
        /// A dynamic parameter to change the volume or loudness of an audio signal.
        case audioVolumeControl = "AudioVolumeControl"
        
        /// A dynamic parameter to change the pan of an audio signal.
        case audioPanControl = "AudioPanControl"
        
        /// A dynamic parameter to change the pitch of an audio signal.
        case audioPitchControl = "AudioPitchControl"
        
        /// A dynamic parameter to change the time when an audio signal's amplitude begins increasing.
        case audioAttackTimeControl = "AudioAttackTimeControl"
        
        /// A dynamic parameter to change the time when an audio signal's amplitude begins decreasing.
        case audioDecayTimeControl = "AudioDecayTimeControl"
        
        /// A dynamic parameter to change the time when an audio signal begins fading.
        case audioReleaseTimeControl = "AudioReleaseTimeControl"
    }
}



extension AHAPPattern {
    
    public var chHapticPattern: CHHapticPattern? {
        guard let dictionary = dictionaryRepresentation() else {
            return nil
        }
        
        return try? .init(dictionary: dictionary)
    }
}


// MARK: - JSON-Formatted Dictionary Representation
extension AHAPPattern {
    
    public func dictionaryRepresentation() -> CHHapticPatternDictionary? {
        guard let data: Data = try? JSONEncoder().encode(self) else {
            return nil
        }
  
        return try? JSONSerialization
            .jsonObject(
                with: data,
                options: .allowFragments
        ) as? [CHHapticPattern.Key: Any]
    }
}
