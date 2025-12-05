// Copyright © 2024 Brent Tunnicliff <brent@tunnicliff.dev>

import Testing

@testable import AdventOfCode

struct Day05Tests {
    private let testData = """
        3-5
        10-14
        16-20
        12-18

        1
        5
        8
        11
        17
        32
        """

    @Test
    func testPart1() {
        let challenge = Day05(data: testData)
        #expect(challenge.part1() == 3)
    }

//    @Test
//    func testPart2() async {
//        let challenge = Day05(data: testData)
//        #expect(challenge.part2() ==)
//    }
}
