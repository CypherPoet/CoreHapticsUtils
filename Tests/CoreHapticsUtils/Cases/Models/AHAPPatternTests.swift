// AHAPPatternTests.swift
//
// Created by CypherPoet.
// ✌️
//
    

import XCTest
import CoreHapticsUtils
import CoreHaptics


class AHAPPatternTests: XCTestCase {
    private typealias SystemUnderTest = AHAPPattern

    private var bundle: Bundle!
//    private var fileName: String!
    private var patternName: String? = nil
    private var ahapVersion: Double!
    private var patternMetadata: AHAPPattern.Metadata? = nil
    private var patternElements: [AHAPPattern.PatternElement] = []
    
    private var sut: SystemUnderTest!
    private var chHapticPatternFromSUT: CHHapticPattern!
}


// MARK: - Lifecycle
extension AHAPPatternTests {

    override func setUp() async throws {
        try await super.setUp()
        
        bundle = .module
        ahapVersion = 1.0
//        fileName = TestConstants.AHAPFileNames.sample1

//        sut = makeSUTFromProperties()
    }


    override func tearDown() async throws {
        try await super.tearDown()

        bundle = nil
//        fileName = nil
        
        patternName = nil
        ahapVersion = nil
        patternMetadata = nil
        patternElements = []
        
        sut = nil
        chHapticPatternFromSUT = nil
    }
}


// MARK: - Factories
extension AHAPPatternTests {

    private func makeSUTFromProperties() -> SystemUnderTest {
        .init(
            name: patternName,
            version: ahapVersion,
            metadata: patternMetadata,
            pattern: patternElements
        )
    }
    
    
    private func makeSUTFromData(
        _ data: Data,
        decodingWith decoder: JSONDecoder
    ) throws -> SystemUnderTest {
        try decoder.decode(SystemUnderTest.self, from: data)
    }
}


// MARK: - "Given" Helpers (Conditions Exist)
extension AHAPPatternTests {
}


// MARK: - "When" Helpers (Actions Are Performed)
extension AHAPPatternTests {

    private func whenSUTIsInitializedFromDecoder(
        _ decoder: JSONDecoder = .init(),
        usingDataInFileNamed fileName: String = TestConstants.FileNames.AHAPPatterns.example1,
        withExtension extensionName: String = "ahap"
    ) throws {
        let url = bundle.url(
            forResource: fileName,
            withExtension: extensionName,
            subdirectory: "ahap-patterns"
        )!
        let data = try Data(contentsOf: url)
        
        sut = try makeSUTFromData(data, decodingWith: decoder)
    }
    
    
    private func whenCHHapticPatternIsComputedFromSUT() throws {
        chHapticPatternFromSUT = try sut.chHapticPattern()
    }
    
    
    private func whenPatternElementsAreInitializedFromDecoder(
        _ decoder: JSONDecoder = .init(),
        usingDataInFileNamed fileName: String = TestConstants.FileNames.AHAPPatternElements.example1
    ) throws {
        let patternElementsURL = bundle.url(
            forResource: fileName,
            withExtension: "json",
            subdirectory: "ahap-pattern-elements"
        )!
        
        let patternElementData = try Data(contentsOf: patternElementsURL)
        
        patternElements = try JSONDecoder().decode(
            [AHAPPattern.PatternElement].self,
            from: patternElementData
        )
    }
}


// MARK: - Test Dictionary Representation
extension AHAPPatternTests {

    func test_DictionaryRepresentation_GivenPatternWithVersionAndElements_CreatesDictionary() throws {
        sut = makeSUTFromProperties()
        
        let _ = try XCTUnwrap(sut.dictionaryRepresentation())
    }
    
    
    func test_ComputedCHHapticPattern_WhenDictionaryIsNotNil_ComputesCHHapticPatternInstance() throws {
        try whenSUTIsInitializedFromDecoder()
        try whenCHHapticPatternIsComputedFromSUT()
        
        XCTAssertGreaterThan(chHapticPatternFromSUT.duration, .zero)
    }
    
    
    func test_DictionaryRepresentation_WhenDictionaryIsNotNil_GeneratesDictionaryThatCanInitializeACHHapticPatternInstance() throws {
        try whenSUTIsInitializedFromDecoder()
        try whenCHHapticPatternIsComputedFromSUT()

        let initialDictionary = sut.dictionaryRepresentation()
        let exportedDictionary = try chHapticPatternFromSUT.exportDictionary() as CHHapticPatternDictionary
        
        XCTAssertEqual(initialDictionary.keys.count, exportedDictionary.keys.count)
        XCTAssertEqual(initialDictionary.keys, exportedDictionary.keys)
    }
}
