// Copyright © 2025 Brent Tunnicliff <brent@tunnicliff.dev>

import AOCHelper
import Algorithms

/// <https://adventofcode.com/2025/day/5>.
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

    func part2() -> Int {
        let (freshRanges, _) = databaseData
        var freshIngredients: [ClosedRange<Int>] = []

        for freshRange in freshRanges {
            let intersectingRanges = freshIngredients.filter {
                $0.overlaps(freshRange)
            }

            guard !intersectingRanges.isEmpty else {
                freshIngredients.append(freshRange)
                continue
            }

            var reducedFreshRanges: [ClosedRange<Int>] = [freshRange]
            for intersectingRange in intersectingRanges {
                var newReducedFreshRanges: [ClosedRange<Int>] = []
                for reducedFreshRange in reducedFreshRanges {
                    if reducedFreshRange.lowerBound < intersectingRange.lowerBound {
                        let newUpperBound = intersectingRange.lowerBound - 1
                        newReducedFreshRanges.append(reducedFreshRange.lowerBound...newUpperBound)
                    }
                    if reducedFreshRange.upperBound > intersectingRange.upperBound {
                        let newLowerBound = intersectingRange.upperBound + 1
                        newReducedFreshRanges.append(newLowerBound...reducedFreshRange.upperBound)
                    }
                }

                reducedFreshRanges = newReducedFreshRanges
            }

            freshIngredients.append(contentsOf: reducedFreshRanges)
        }

        var result = 0
        for freshIngredient in freshIngredients {
            result += freshIngredient.count
        }

        return result
    }
}
