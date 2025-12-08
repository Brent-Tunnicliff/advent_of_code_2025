// Copyright © 2025 Brent Tunnicliff <brent@tunnicliff.dev>

import AOCHelper
import Algorithms

/// <https://adventofcode.com/2025/day/1>.
struct Day01: AdventDay {
    let data: String
    private let rangerOfClicksPerRotation = 0..<100

    private var rows: [String] {
        data.split(separator: "\n")
            .map(String.init)
    }

    func part1() -> Int {
        countZeroClicks(countOnlyEndPosition: true)
    }

    func part2() -> Int {
        countZeroClicks(countOnlyEndPosition: false)
    }

    private func countZeroClicks(countOnlyEndPosition: Bool) -> Int {
        var position = 50
        var result = 0

        for row in rows where !row.isEmpty {
            guard let direction = row.first, let clicks = Int(row.dropFirst()) else {
                preconditionFailure("Unable to parse row: \(row)")
            }

            let isStartingPlaceLowerBound = position == rangerOfClicksPerRotation.lowerBound
            var didClickLowerBound = false
            let clickLimit = rangerOfClicksPerRotation.count
            var reducedClicks = clicks
            while reducedClicks > clickLimit {
                reducedClicks -= clickLimit
                if !countOnlyEndPosition {
                    result += 1
                }
            }

            let adjustedClicks = direction == "R" ? reducedClicks : -reducedClicks
            let newPosition = position + adjustedClicks
            let newValidPosition: Int
            if rangerOfClicksPerRotation.contains(newPosition) {
                newValidPosition = newPosition
            } else if newPosition < rangerOfClicksPerRotation.lowerBound {
                newValidPosition = newPosition + rangerOfClicksPerRotation.upperBound
                didClickLowerBound = true
            } else {
                newValidPosition = newPosition - rangerOfClicksPerRotation.upperBound
                didClickLowerBound = true
            }

            if countOnlyEndPosition {
                if newValidPosition == 0 {
                    result += 1
                }
            } else {
                let shouldCountLowerBoundClick =
                    newValidPosition == 0
                    || (!isStartingPlaceLowerBound && didClickLowerBound)
                if shouldCountLowerBoundClick {
                    result += 1
                }
            }

            position = newValidPosition
        }

        return result
    }
}
