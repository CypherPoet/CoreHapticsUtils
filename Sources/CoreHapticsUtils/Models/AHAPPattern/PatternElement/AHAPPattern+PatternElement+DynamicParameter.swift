// AHAPPattern+PatternElement+DynamicParameter.swift
//
// Created by CypherPoet.
// ✌️
//
    
import Foundation
import CoreHaptics


extension AHAPPattern.PatternElement {

    public struct DynamicParameter: Codable {
        public let parameterID: AHAPPattern.DynamicParameterID?
        public let parameterValue: Double?
        
        enum CodingKeys: CHHapticPattern.Key.RawValue, CodingKey {
            case parameterID = "ParameterID"
            case parameterValue = "ParameterValue"
        }
    }
}
