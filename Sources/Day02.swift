// Copyright © 2025 Brent Tunnicliff <brent@tunnicliff.dev>

import AOCHelper
import Algorithms

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

//    func part2() -> Int {
//    }

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
