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
                    $0.toInt()
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

                    let joltage = "\(instance.element)\(secondDigit)".toInt()
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

    func part2() async -> Int {
        await withTaskGroup { group in
            for bank in banks {
                group.addTask {
                    let enumeratedBank = Array(bank.enumerated())
                    return calculateLargestJoltage(
                        for: enumeratedBank,
                        currentJoltageDigits: [],
                        numberOfDigits: 12
                    ) ?? 0
                }
            }

            var result = 0
            for await largestJoltage in group {
                result += largestJoltage
            }

            return result
        }
    }

    private func calculateLargestJoltage(
        for bankEnumerated: [EnumeratedSequence<[Int]>.Element],
        currentJoltageDigits: [EnumeratedSequence<[Int]>.Element],
        numberOfDigits: Int
    ) -> Int? {
        guard currentJoltageDigits.count < numberOfDigits else {
            // Found a solution
            return currentJoltageDigits.map(\.element.description)
                .joined()
                .toInt()
        }

        let lastDigitOffset = currentJoltageDigits.last?.offset ?? -1

        var filteredNumbers = bankEnumerated.filter { $0.offset > lastDigitOffset }
            .map(\.element)
            .toSet()

        while !filteredNumbers.isEmpty {
            guard let nextDigit = filteredNumbers.max() else {
                preconditionFailure("Array is not empty, but there is no max number?")
            }

            let allValues = bankEnumerated.filter { $0.element == nextDigit && $0.offset > lastDigitOffset }
                .compactMap {
                    let newCurrentJoltageDigits = currentJoltageDigits + [$0]
                    return calculateLargestJoltage(
                        for: bankEnumerated,
                        currentJoltageDigits: newCurrentJoltageDigits,
                        numberOfDigits: numberOfDigits
                    )
                }

            guard let potentialResult = allValues.max() else {
                filteredNumbers.remove(nextDigit)
                continue
            }

            return potentialResult
        }

        return nil
    }
}
