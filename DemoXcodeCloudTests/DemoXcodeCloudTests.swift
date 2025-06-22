//
//  DemoXcodeCloudTests.swift
//  DemoXcodeCloudTests
//
//  Created by Đỗ Lê Duy on 21/4/25.
//

import Testing
@testable import DemoXcodeCloud

struct DemoXcodeCloudTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

    @Test func addTest() async throws {
        #expect(Math.add(1, 1) == 2)
    }
}
