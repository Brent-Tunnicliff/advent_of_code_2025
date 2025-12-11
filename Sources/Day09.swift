// Copyright © 2025 Brent Tunnicliff <brent@tunnicliff.dev>

import AOCHelper
import Algorithms
import Foundation

/// <https://adventofcode.com/2025/day/9>.
struct Day09: AdventDay {
    let data: String

    private var input: [Coordinates] {
        data.trimmingWhitespaces().split(separator: "\n").reduce(into: [Coordinates]()) { partialResult, row in
            let numbers = row.split(separator: ",").map { $0.toInt() }
            precondition(numbers.count == 2, "Unexpected number count on row \(row)")
            partialResult.append(
                Coordinates(x: numbers[0], y: numbers[1])
            )
        }
    }

    func part1() -> Int {
        let input = self.input
        var largestArea = 0
        var countedAlready: [[Coordinates]] = []

        for initialPoint in input {
            let otherPoint = input.map {
                (point: $0, distance: initialPoint.distance(to: $0))
            }.max {
                $0.distance < $1.distance
            }?.point

            guard let otherPoint else {
                continue
            }

            let bothPoints: [Coordinates] = [initialPoint, otherPoint]
            guard !countedAlready.contains(contentsOf: bothPoints) else {
                continue
            }

            let calculateSide = { (lhs: Int, rhs: Int) in
                max(lhs, rhs) - min(lhs, rhs)
            }

            let sideOne = calculateSide(initialPoint.x, otherPoint.x) + 1
            let sideTwo = calculateSide(initialPoint.y, otherPoint.y) + 1
            let area = sideOne * sideTwo
            if area > largestArea {
                largestArea = area
            }
            countedAlready.append(bothPoints)
        }

        return largestArea
    }
}

extension [Coordinates] {
    fileprivate func contains(contentsOf other: [Coordinates]) -> Bool {
        guard other.count == count else {
            return false
        }

        for value in other where !contains(value) {
            return false
        }

        return true
    }
}

extension [[Coordinates]] {
    fileprivate func contains(contentsOf other: [Coordinates]) -> Bool {
        for collection in self where collection.contains(contentsOf: other) {
            return true
        }

        return false
    }
}
