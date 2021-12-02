// AHAPPattern.swift
//
// Created by CypherPoet.
// ✌️
//

import Foundation
import CoreHaptics
import os


public struct AHAPPattern {
    public var name: String?
    public var version: Double
    public var metadata: Metadata?
    public var pattern: [PatternElement]
    
    
    // MARK: - Init
    public init(
        name: String? = nil,
        version: Double,
        metadata: Metadata? = nil,
        pattern: [PatternElement] = []
    ){
        self.name = name
        self.version = version
        self.metadata = metadata
        self.pattern = pattern
    }
}


extension AHAPPattern {
    public typealias Metadata = [String: String]
}


extension AHAPPattern: Codable {}


// MARK: - Coding Keys
extension AHAPPattern {
    
    enum CodingKeys: CHHapticPattern.Key.RawValue, CodingKey {
        case version = "Version"
        case metadata = "Metadata"
        case pattern = "Pattern"
    }
}


// MARK: -  Computeds
extension AHAPPattern {
    
    public func chHapticPattern() throws -> CHHapticPattern {
        let dictionary = dictionaryRepresentation()
        
        return try CHHapticPattern(dictionary: dictionary)
    }
}


// MARK: - JSON-Formatted Dictionary Representation
extension AHAPPattern {
    
    public func dictionaryRepresentation() -> CHHapticPatternDictionary {
        let data = try! JSONEncoder().encode(self)
        
        return try! JSONSerialization
            .jsonObject(
                with: data,
                options: .fragmentsAllowed
            ) as! CHHapticPatternDictionary
    }
}


// MARK: -  Logger
extension AHAPPattern {
    
    private static let logger = Logger(
        subsystem: Bundle.module.bundleIdentifier!,
        category: String(describing: AHAPPattern.self)
    )
}
