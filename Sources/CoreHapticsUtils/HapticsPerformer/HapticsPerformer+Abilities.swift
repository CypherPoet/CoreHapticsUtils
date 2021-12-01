// HapticsPerformer+Abilities.swift
//
// Created by CypherPoet.
// ✌️
//
    
import Foundation


extension HapticsPerformer {
    
    public enum Abilities {
        
        /// The haptic engine ignores audio events.
        ///
        /// Setting this property to `true` causes the engine to ignore all audio events,
        /// such as `audioContinuous` and `audioCustom`.
        /// This also reduces latency of starting haptic playback.
        ///
        /// > Important: Changing the value of this property on a running engine has no effect
        /// until you stop and restart the engine.
        case hapticsOnly
        
        /// The haptic engine will attempt to play haptics and audio events.
        case audioEnabled
    }
}
