// AHAPPattern+EventParameterID.swift
//
// Created by CypherPoet.
// ✌️
//
    
import Foundation


extension AHAPPattern {

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
