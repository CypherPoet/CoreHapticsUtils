// AHAPPattern+DynamicParameterID.swift
//
// Created by CypherPoet.
// ✌️
//
    
import Foundation


extension AHAPPattern {
    
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
