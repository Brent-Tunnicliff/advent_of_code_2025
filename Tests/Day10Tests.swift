// Copyright © 2024 Brent Tunnicliff <brent@tunnicliff.dev>

import Testing

@testable import AdventOfCode

struct Day10Tests {
    private let testData = """
        [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
        [...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
        [.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
        """

    @Test
    func testPart1() {
        let challenge = Day10(data: testData)
        #expect(challenge.part1() == 7)
    }

//    @Test
//    func testPart2() async {
//        let challenge = Day10(data: testData)
//        #expect(challenge.part2() == )
//    }
}
