//
//  AlarmAppTests.swift
//  AlarmAppTests
//
//  Created by Brice Pollock on 2/20/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import XCTest
@testable import AlarmApp

class HandshakeNetworkHelperTests: XCTestCase {
    let helper = HandshakeNetworkHelper()

    func testCreateURL_alarms() {
        guard let result = helper.createURL(for: .alarms) else { XCTFail(); return }
        let expected = "https://bellbird.joinhandshake-internal.com/alarms.json"
        
        XCTAssertEqual(result.absoluteString, expected)
    }
    
    func testCreateURL_updateAlarms() {
        guard let result = helper.createURL(for: .updateAlarm(1)) else { XCTFail(); return }
        let expected = "https://bellbird.joinhandshake-internal.com/alarms/1.json"
        XCTAssertEqual(result.absoluteString, expected)
    }
}
