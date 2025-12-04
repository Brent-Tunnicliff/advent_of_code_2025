// Copyright © 2024 Brent Tunnicliff <brent@tunnicliff.dev>

import Testing

@testable import AdventOfCode

struct Day04Tests {
    private let testData = """
        ..@@.@@@@.
        @@@.@.@.@@
        @@@@@.@.@@
        @.@@@@..@.
        @@.@@@@.@@
        .@@@@@@@.@
        .@.@.@.@@@
        @.@@@.@@@@
        .@@@@@@@@.
        @.@.@@@.@.
        """

    @Test
    func testPart1() {
        let challenge = Day04(data: testData)
        #expect(challenge.part1() == 13)
    }

//    @Test
//    func testPart2() async {
//        let challenge = Day04(data: testData)
//        await #expect(challenge.part2() == )
//    }
}
