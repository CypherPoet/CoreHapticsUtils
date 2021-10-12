// AHAPPattern+PatternElement+DynamicParameterCurve.swift
//
// Created by CypherPoet.
// ✌️
//
    
import Foundation
import CoreHaptics


fileprivate typealias DynamicParameterCurve = AHAPPattern.PatternElement.DynamicParameterCurve


extension AHAPPattern.PatternElement {
    
    public struct DynamicParameterCurve: Codable {
        public let parameterID: AHAPPattern.DynamicParameterID?
        public let time: TimeInterval?
        public let parameterCurveControlPoints: [ControlPoint]?
        
        enum CodingKeys: CHHapticPattern.Key.RawValue, CodingKey {
            case parameterID = "ParameterID"
            case time = "Time"
            case parameterCurveControlPoints = "ParameterCurveControlPoints"
        }
    }
}


// MARK: - ControlPoint
extension DynamicParameterCurve {
    
    public struct ControlPoint: Codable {
        public let time: TimeInterval?
        public let parameterValue: Double?
        
        enum CodingKeys: CHHapticPattern.Key.RawValue, CodingKey {
            case time = "Time"
            case parameterValue = "ParameterValue"
        }
    }
}
