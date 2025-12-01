// Copyright © 2024 Brent Tunnicliff <brent@tunnicliff.dev>

import Testing

@testable import AdventOfCode

struct Day01Tests {
    private let testData = """
        L68
        L30
        R48
        L5
        R60
        L55
        L1
        L99
        R14
        L82
        """

    @Test
    func testPart1() {
        let challenge = Day01(data: testData)
        #expect(challenge.part1() == 3)
    }

    @Test
    func testPart2() {
        let challenge = Day01(data: testData)
        #expect(challenge.part2() == 6)
    }
}
