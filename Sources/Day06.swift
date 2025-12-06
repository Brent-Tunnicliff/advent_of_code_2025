// Copyright © 2025 Brent Tunnicliff <brent@tunnicliff.dev>

import AOCHelper
import Algorithms

struct Day06: AdventDay {
    let data: String

    private var homework: [(numbers: [Int], symbol: ProblemSymbol)] {
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
        let homework = homework
        var result = 0
        for (numbers, symbol) in homework {
            var current: Int = numbers[0]
            for number in numbers.suffix(from: 1) {
                current = symbol.calculate(lhs: current, rhs: number)
            }

            result += current
            print("\(symbol), \(current), \(numbers)")
        }

        return result
    }

//    func part2() -> Int {
//
//    }
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
