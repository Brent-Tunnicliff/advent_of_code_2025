// Copyright © 2025 Brent Tunnicliff <brent@tunnicliff.dev>

import AOCHelper
import Algorithms

/// <https://adventofcode.com/2025/day/6>.
struct Day06: AdventDay {
    let data: String

    private var partOneHomework: [(numbers: [Int], symbol: ProblemSymbol)] {
        let rows = self.data.trimmingWhitespaces().split(separator: "\n")

        var symbols: [ProblemSymbol] = []
        for number in rows[rows.count - 1].split(separator: " ") {
            symbols.append(ProblemSymbol.init(rawValue: number.toString()))
        }

        var numberMappings: [Int: [Int]] = [:]
        for row in rows.dropLast() {
            for (offset, number) in row.split(separator: " ").enumerated() {
                numberMappings[offset] = (numberMappings[offset] ?? []) + [number.toInt()]
            }
        }

        return symbols.enumerated().map {
            guard let numbers = numberMappings[$0.offset] else {
                preconditionFailure("Missing numbers for index \($0.offset)")
            }

            return (numbers, $0.element)
        }
    }

    func part1() -> Int {
        calculate(homework: partOneHomework)
    }

    private var partTwoHomework: [(numbers: [Int], symbol: ProblemSymbol)] {
        let rows = self.data.trimmingWhitespaces().split(separator: "\n")
        let numberRows = rows.dropLast()

        let symbolsRow = rows[rows.count - 1]
        let symbolIndexes = symbolsRow.enumerated().filter { $0.element != " " }
        var homework: [(numbers: [Int], symbol: ProblemSymbol)] = []
        for (symbolOffset, symbolString) in symbolIndexes {
            let symbol = ProblemSymbol(rawValue: symbolString.toString())
            let upperBound = (symbolIndexes.first(where: { $0.offset > symbolOffset })?.offset ?? data.count) - 1
            let range = symbolOffset...upperBound
            var numbers: [Int] = []
            for numberOffset in range.reversed() {
                var digits: [Int] = []
                for row in numberRows {
                    guard let digit = row.dropFirst(numberOffset).first, let number = Int(digit.toString()) else {
                        continue
                    }

                    digits.append(number)
                }

                guard !digits.isEmpty else {
                    continue
                }

                numbers.append(digits.map(\.description).joined().toInt())
            }

            homework.append((numbers, symbol))
        }

        return homework
    }

    func part2() -> Int {
        calculate(homework: partTwoHomework)
    }

    private func calculate(homework: [(numbers: [Int], symbol: ProblemSymbol)]) -> Int {
        var result = 0
        for (numbers, symbol) in homework {
            var current: Int = numbers[0]
            for number in numbers.suffix(from: 1) {
                current = symbol.calculate(lhs: current, rhs: number)
            }

            result += current
        }

        return result
    }
}

private enum ProblemSymbol {
    case added
    case multiplied

    init(rawValue: String) {
        switch rawValue.trimmingWhitespaces() {
        case "+": self = .added
        case "*": self = .multiplied
        default: preconditionFailure("Invalid symbol: \(rawValue)")
        }
    }

    func calculate(lhs: Int, rhs: Int) -> Int {
        switch self {
        case .added: lhs + rhs
        case .multiplied: lhs * rhs
        }
    }
}
