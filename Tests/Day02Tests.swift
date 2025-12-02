// Copyright © 2024 Brent Tunnicliff <brent@tunnicliff.dev>

import Testing

@testable import AdventOfCode

struct Day02Tests {
    private let testData = """
        11-22,95-115,998-1012,1188511880-1188511890,222220-222224,\
        1698522-1698528,446443-446449,38593856-38593862,565653-565659,\
        824824821-824824827,2121212118-2121212124
        """

    @Test
    func testPart1() {
        let challenge = Day02(data: testData)
        #expect(challenge.part1() == 1_227_775_554)
    }

//    @Test
//    func testPart2() {
//        let challenge = Day02(data: testData)
//        #expect(challenge.part2() == )
//    }
}
