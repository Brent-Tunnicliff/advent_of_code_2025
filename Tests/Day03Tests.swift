// Copyright © 2024 Brent Tunnicliff <brent@tunnicliff.dev>

import Testing

@testable import AdventOfCode

struct Day03Tests {
    private let testData = """
        987654321111111
        811111111111119
        234234234234278
        818181911112111
        """

    @Test
    func testPart1() {
        let challenge = Day03(data: testData)
        #expect(challenge.part1() == 357)
    }

    @Test
    func testPart2() async {
        let challenge = Day03(data: testData)
        await #expect(challenge.part2() == 3_121_910_778_619)
    }
}
