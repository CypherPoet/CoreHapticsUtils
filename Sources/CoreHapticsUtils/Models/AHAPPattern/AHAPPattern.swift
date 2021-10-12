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
    public var metadata: Metadata?
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
    public typealias Metadata = [String: String]
}


// MARK: -  Computeds
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