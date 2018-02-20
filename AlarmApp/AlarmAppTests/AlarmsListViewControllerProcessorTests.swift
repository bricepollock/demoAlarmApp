//
//  AlarmsListViewControllerProcessorTests.swift
//  AlarmAppTests
//
//  Created by Brice Pollock on 2/20/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import XCTest
@testable import AlarmApp

class AlarmsListViewControllerProcessorTests: XCTestCase {
    let processor = AlarmsListViewControllerProcessor()
    
    // MARK: bodyString
    func testBodyString_empty() {
        let result = processor.bodyString(from: "")
        let expected = ""
        XCTAssertEqual(result, expected)
    }
    
    func testBodyString_lowercase() {
        let result = processor.bodyString(from: "i like alarms")
        let expected = "I LIKE ALARMS"
        XCTAssertEqual(result, expected)
    }
    
    func testBodyString_mixedCase() {
        let result = processor.bodyString(from: "HelLoz")
        let expected = "HELLOZ"
        XCTAssertEqual(result, expected)
    }
    
    func testBodyString_uppercase() {
        let result = processor.bodyString(from: "I LOVE ALARMS")
        let expected = "I LOVE ALARMS"
        XCTAssertEqual(result, expected)
    }
    
    // MARK: voteString
    func testVoteString_nil() {
        let result = processor.voteString(from: nil)
        let expected = "0 votes"
        XCTAssertEqual(result, expected)
    }
    
    func testVoteString_negative() {
        let result = processor.voteString(from: -1)
        let expected = "0 votes"
        XCTAssertEqual(result, expected)
    }
    
    func testVoteString_zero() {
        let result = processor.voteString(from: 0)
        let expected = "0 votes"
        XCTAssertEqual(result, expected)
    }
    
    func testVoteString_singleDigit() {
        let result = processor.voteString(from: 7)
        let expected = "7 votes"
        XCTAssertEqual(result, expected)
    }
    
    func testVoteString_large() {
        let result = processor.voteString(from: 234567890)
        let expected = "234567890 votes"
        XCTAssertEqual(result, expected)
    }
    
}
