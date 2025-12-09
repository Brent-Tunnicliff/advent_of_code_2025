// Copyright © 2024 Brent Tunnicliff <brent@tunnicliff.dev>

import Testing

@testable import AdventOfCode

struct Day09Tests {
    private let testData = """
        7,1
        11,1
        11,7
        9,7
        9,5
        2,5
        2,3
        7,3
        """

    @Test
    func testPart1() {
        let challenge = Day09(data: testData)
        #expect(challenge.part1() == 50)
    }

//    @Test
//    func testPart2() async {
//        let challenge = Day09(data: testData)
//        #expect(challenge.part2() == )
//    }
}
