// Copyright © 2025 Brent Tunnicliff <brent@tunnicliff.dev>

import AOCHelper
import Algorithms

struct Day03: AdventDay {
    let data: String

    private var banks: [[Int]] {
        data.trimmingWhitespaces()
            .split(separator: "\n")
            .map { row in
                row.map {
                    guard let number = Int($0.description) else {
                        preconditionFailure("Unable to convert '\($0)' to Int")
                    }

                    return number
                }
            }
    }

    func part1() -> Int {
        var result = 0
        for bank in banks {
            let enumeratedBank = Array(bank.enumerated())
            var mutatableEnumeratedBank = enumeratedBank
            while !mutatableEnumeratedBank.isEmpty {
                guard let highestNumber = mutatableEnumeratedBank.max(by: { $0.element < $1.element })?.element else {
                    preconditionFailure("Array is not empty, but there is no max number?")
                }

                let allInstancesOfHighestNumber = mutatableEnumeratedBank.filter { $0.element == highestNumber }
                var largestJoltage: Int?
                for instance in allInstancesOfHighestNumber {
                    // We only want numbers after the current value.
                    let potentialSecondDigits = enumeratedBank.filter { $0.offset > instance.offset }.map(\.element)
                    guard let secondDigit = potentialSecondDigits.max() else {
                        // no matching second digit
                        continue
                    }

                    let joltageString = "\(instance.element)\(secondDigit)"
                    guard let joltage = Int(joltageString) else {
                        preconditionFailure("Unable to convert '\(joltageString)' to Int")
                    }

                    if (largestJoltage ?? 0) < joltage {
                        largestJoltage = joltage
                    }
                }

                guard let largestJoltage else {
                    // Remove the largest number and try again.
                    mutatableEnumeratedBank.removeAll(where: { $0.element == highestNumber })
                    continue
                }

                result += largestJoltage
                break
            }
        }

        return result
    }

//    func part2() -> Int {
//    }
}
