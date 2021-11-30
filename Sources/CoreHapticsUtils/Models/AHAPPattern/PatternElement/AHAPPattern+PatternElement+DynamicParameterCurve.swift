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
        
        /// The time at which to start applying the parameter curve.
        public let relativeTime: TimeInterval?
        
        /// An array of control points defining how the parameter curve changes over time.
        public let parameterCurveControlPoints: [ControlPoint]?
        
        enum CodingKeys: CHHapticPattern.Key.RawValue, CodingKey {
            case parameterID = "ParameterID"
            case relativeTime = "Time"
            case parameterCurveControlPoints = "ParameterCurveControlPoints"
        }
    }
}


// MARK: - ControlPoint
extension DynamicParameterCurve {
    
    public struct ControlPoint: Codable {
        
        /// The time at which the associated parameter reaches this value,
        /// relative to the start time of the parameter curve.
        public let time: TimeInterval?
        
        /// The parameter value of the point.
        public let parameterValue: Double?
        
        enum CodingKeys: CHHapticPattern.Key.RawValue, CodingKey {
            case time = "Time"
            case parameterValue = "ParameterValue"
        }
    }
}
