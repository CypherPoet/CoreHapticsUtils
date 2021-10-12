// AHAPPattern+PatternElement.swift
//
// Created by CypherPoet.
// ✌️
//
    
import Foundation
import CoreHaptics


fileprivate typealias PatternElement = AHAPPattern.PatternElement


extension AHAPPattern {
    
    public struct PatternElement {
        public let event: Event?
        public let dynamicParameter: DynamicParameter?
        public let dynamicParameterCurve: DynamicParameterCurve?
    }
}


// MARK: - Coding Keys
extension PatternElement {
    
    enum CodingKeys: CHHapticPattern.Key.RawValue, CodingKey {
        case event = "Event"
        case dynamicParameter = "Parameter"
        case dynamicParameterCurve = "ParameterCurve"
    }
}

extension PatternElement: Codable {}

