// AHAPPattern.swift
//
// Created by CypherPoet.
// ✌️
//

import Foundation
import CoreHaptics


public typealias CHHapticPatternDictionary = [CHHapticPattern.Key: Any]


public struct AHAPPattern {
    public var name: String?
    public var version: Double?
    public var metadata: Metadata?
    public var pattern: [PatternElement]
}


// MARK: - Init
extension AHAPPattern {
    
    public init(data: Data) throws {
        let decoder = JSONDecoder()
        
        self = try decoder.decode(Self.self, from: data)
    }
}

extension AHAPPattern: Codable {}


// MARK: -  Error
extension AHAPPattern {
    
    public enum Error: Swift.Error {
        case failedToMakeDictionaryFromPattern(Swift.Error)
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
    public typealias Metadata = [String: String]
}


// MARK: -  Computeds
extension AHAPPattern {
    
    public func chHapticPattern() throws -> CHHapticPattern {
        let dictionary = try dictionaryRepresentation()
        
        return try CHHapticPattern(dictionary: dictionary)
    }
}


// MARK: - JSON-Formatted Dictionary Representation
extension AHAPPattern {
    
    public func dictionaryRepresentation() throws -> CHHapticPatternDictionary {
        do {
            let data = try JSONEncoder().encode(self)
            
            return try JSONSerialization
                .jsonObject(
                    with: data,
                    options: .allowFragments
            ) as! [CHHapticPattern.Key: Any]
        } catch {
            throw Error.failedToMakeDictionaryFromPattern(error)
        }
    }
}
