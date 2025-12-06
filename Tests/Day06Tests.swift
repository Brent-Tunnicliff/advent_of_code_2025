// Copyright © 2024 Brent Tunnicliff <brent@tunnicliff.dev>

import Testing

@testable import AdventOfCode

struct Day06Tests {
    private let testData = """
        123 328  51 64 
         45 64  387 23 
          6 98  215 314
        *   +   *   +  
        """

    @Test
    func testPart1() {
        let challenge = Day06(data: testData)
        #expect(challenge.part1() == 4277556)
    }

//    @Test
//    func testPart2() async {
//        let challenge = Day06(data: testData)
//        #expect(challenge.part2() == )
//    }
}
