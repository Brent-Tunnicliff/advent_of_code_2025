// Copyright © 2025 Brent Tunnicliff <brent@tunnicliff.dev>

import AOCHelper
import Algorithms

struct Day05: AdventDay {
    let data: String

    private var databaseData: (freshRanges: [ClosedRange<Int>], ingredients: [Int]) {
        let sections = data.trimmingWhitespaces().split(separator: "\n\n")
        precondition(sections.count == 2)

        let freshRanges = sections[0].split(separator: "\n").map { freshRangesLine in
            let bounds = freshRangesLine.split(separator: "-").map { $0.toInt() }.sorted()
            precondition(bounds.count == 2)
            return bounds[0]...bounds[1]
        }

        let ingredients = sections[1].split(separator: "\n").map { $0.toInt() }
        return (freshRanges, ingredients)
    }

    func part1() -> Int {
        let (freshRanges, ingredients) = databaseData
        var result = 0

        for ingredient in ingredients {
            for freshRange in freshRanges where freshRange.contains(ingredient) {
                result += 1
                break
            }
        }

        return result
    }

//    func part2() -> Int {
//    }
}
