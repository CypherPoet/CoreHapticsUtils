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
    private var fileName: String!
    private var sut: SystemUnderTest!
}


// MARK: - Lifecycle
extension AHAPPatternTests {

    override func setUp() async throws {
        try await super.setUp()
        
        bundle = .module
        fileName = TestConstants.AHAPFileNames.sample1

//        sut = makeSUT()
    }


    override func tearDown() async throws {
        try await super.tearDown()

        bundle = nil
        fileName = nil
        sut = nil
    }
}


// MARK: - Factories
extension AHAPPatternTests {

    private func makeSUT() throws -> SystemUnderTest {
        try .init(
            fileName: fileName,
            bundle: bundle
        )
    }
}


// MARK: - "Given" Helpers (Conditions Exist)
extension AHAPPatternTests {

    private func givenSomething() {
        // some state or condition is established
    }
}


// MARK: - "When" Helpers (Actions Are Performed)
extension AHAPPatternTests {

    private func whenSomethingHappens() {
        // perform some action
    }
}


// MARK: - Test Initialization with Custom Arguments
extension AHAPPatternTests {

    func test_Init_GivenFileName_WhenFileCantBeFound_ThrowsAHAPFileNotFoundError() throws {
        fileName = "nope"
        
        do {
            sut = try makeSUT()
            XCTFail("Expected error to be thrown before here.")
        } catch let ahapPatternError as AHAPPattern.Error {
            switch ahapPatternError {
            case .ahapFileNotFound(let fileName):
                XCTAssertEqual(fileName, self.fileName)
            default:
                XCTFail("Unexpected error type")
            }
        } catch {
            XCTFail("Unexpected error type")
        }
    }
    
    
    func test_Init_GivenFileName_WhenFileNameIsValidAHAPFile_CreatesPattern() throws {
        do {
            sut = try makeSUT()
        } catch {
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }
}


// MARK: - Test Initial Properties
extension AHAPPatternTests {

    func test_Init_GivenDataWithListOfPatternElements_StorePatternsArray() throws {
        sut = try makeSUT()
        
        let patternElements = try XCTUnwrap(sut.pattern)
        
        XCTAssertEqual(patternElements.count, 5)
    }
}



// MARK: - Test Dictionary Representation
extension AHAPPatternTests {

    func test_DictionaryRepresentation_GivenPatternWithVersionAndElements_CreatesDictionary() throws {
        sut = try makeSUT()
        
        let _ = try XCTUnwrap(sut.dictionaryRepresentation())
    }
    
    
    func test_DictionaryRepresentation_WhenDictionaryIsNotNil_GeneratesDictionaryThatCanInitializeACHHapticPatternInstance() throws {
        sut = try makeSUT()
        
        let initialDictionary = try XCTUnwrap(sut.dictionaryRepresentation())
        let chHapticPattern = try CHHapticPattern(dictionary: initialDictionary)
        let exportedDictionary = try chHapticPattern.exportDictionary() as CHHapticPatternDictionary
        
        XCTAssertEqual(initialDictionary.keys.count, exportedDictionary.keys.count)
        XCTAssertEqual(initialDictionary.keys, exportedDictionary.keys)
    }
    
    
    func test_ComputedCHHapticPattern_WhenDictionaryIsNotNil_ComputesCHHapticPatternInstance() throws {
        sut = try makeSUT()
        
        let _ = try XCTUnwrap(sut.chHapticPattern)
    }
}
