// Copyright © 2025 Brent Tunnicliff <brent@tunnicliff.dev>

import AOCHelper
import Algorithms

/// <https://adventofcode.com/2025/day/2>.
struct Day02: AdventDay {
    let data: String

    private var ranges: [ClosedRange<Int>] {
        data.trimmingWhitespaces()
            .split(separator: ",")
            .reduce(into: [ClosedRange<Int>]()) { partialResult, value in
                let numbers = value.split(separator: "-")
                    .compactMap { Int($0) }

                precondition(numbers.count == 2, "Unexpected count \(numbers.count) for '\(value)'")
                let lower = numbers[0]
                let upper = numbers[1]
                partialResult.append(lower...upper)
            }
    }

    func part1() -> Int {
        var result = 0

        for range in ranges {
            let lowerBoundSplit = split(number: range.lowerBound, removeMoreWhenOdd: true)
            let upperBoundSplit = split(number: range.upperBound, removeMoreWhenOdd: false)
            let rangeOfPossibleValues = lowerBoundSplit...upperBoundSplit
            for possibleValue in rangeOfPossibleValues {
                let combined = "\(possibleValue)\(possibleValue)"
                guard let value = Int(combined) else {
                    preconditionFailure("Couldn't convert \(combined) to Int")
                }

                if range.contains(value) {
                    result += value
                }
            }
        }

        return result
    }

    func part2() -> Int {
        var result = 0

        for range in ranges {
            let lowerBoundSplit = split(number: range.lowerBound, removeMoreWhenOdd: true)
            let upperBoundSplit = split(number: range.upperBound, removeMoreWhenOdd: false)
            let rangeOfPossibleValues = lowerBoundSplit...upperBoundSplit
            var includingRepeating: Set<Int> = []
            for possibleValue in rangeOfPossibleValues {
                for numberToDrop in (0..<possibleValue.description.count) {
                    let string = possibleValue.description.dropLast(numberToDrop)
                    guard let initialValue = Int(string) else {
                        preconditionFailure("Couldn't convert '\(string)' to Int")
                    }

                    var value = initialValue
                    while value.description.count < range.lowerBound.description.count {
                        let combined = "\(value)\(initialValue)"
                        guard let newValue = Int(combined) else {
                            preconditionFailure("Couldn't convert '\(combined)' to Int")
                        }

                        value = newValue
                    }

                    // Add value, we see a case in the input data of single digits,
                    // but we don't want those.
                    if value.description.count > 1 {
                        includingRepeating.insert(value)
                    }

                    // Keep going until we reach the upper bound length.
                    while value.description.count <= range.upperBound.description.count {
                        let combined = "\(value)\(initialValue)"
                        guard let newValue = Int(combined) else {
                            preconditionFailure("Couldn't convert '\(combined)' to Int")
                        }

                        value = newValue
                        includingRepeating.insert(value)
                    }
                }
            }

            for number in includingRepeating where range.contains(number) {
                result += number
            }
        }

        return result
    }

    /// Returns the first half digits for a number.
    private func split(number: Int, removeMoreWhenOdd: Bool) -> Int {
        guard number > 9 else {
            return number
        }

        let string = number.description
        let roundUpModifier = removeMoreWhenOdd ? 1 : 0

        // We want to round up.
        let numberToDrop = (string.count + roundUpModifier) / 2
        let firstHalf = number.description.dropLast(numberToDrop)
        guard let result = Int(firstHalf) else {
            preconditionFailure("Couldn't convert \(firstHalf) to Int")
        }

        return result
    }
}
