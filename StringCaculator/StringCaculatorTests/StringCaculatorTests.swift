//
//  StringCaculatorTests.swift
//  StringCaculatorTests
//
//  Created by Wei Xu on 2021-09-08.
//

import XCTest
@testable import StringCaculator

class StringCaculatorTests: XCTestCase {
    
    let caculator = StringCaculator()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEmpty() {
        XCTAssertEqual(try caculator.Add(numbers: ""), 0, "Empty String")
    }
    
    func testNormal() {
        XCTAssertEqual(try caculator.Add(numbers: "1,2,5"), 8, "Test 1,2,5")
    }

    func testWithNewLines() {
        XCTAssertEqual(try caculator.Add(numbers: "1\n,2,3"), 6, "Test 1\n,2,3")
        XCTAssertEqual(try caculator.Add(numbers: "1,\n2,4"), 7, "Test 1,\n2,4")
    }
    
    func testDelimiter(){
        XCTAssertEqual(try caculator.Add(numbers: "//;\n1;3;4"), 8, "Test //;\n1;3;4")
        XCTAssertEqual(try caculator.Add(numbers: "//$\n1$2$3"), 6, "Test //$\n1$2$3")
        XCTAssertEqual(try caculator.Add(numbers: "//@\n2@3@8"), 13, "Test //@\n2@3@8")
    }
    
    func testError() {
        XCTAssertThrowsError(try caculator.Add(numbers: "//;\n1;-3;4")) { error in
            XCTAssertEqual(error as? MyError, MyError.negativeError("Negatives not allowed: -3 is negative"))
        }
    }
    
    func testMaximun() {
        XCTAssertEqual(try caculator.Add(numbers: "2,1001"), 2, "Test 2,1001")
    }
    
    func testArbitraryLength() {
        XCTAssertEqual(try caculator.Add(numbers: "//***\n1***2***3"), 6, "Test //***\n1***2***3")
    }
    
    func testMultipleDelimiter() {
        XCTAssertEqual(try caculator.Add(numbers: "//$,@\n1$2@3"), 6, "Test //$,@\n1$2@3")
    }
}
