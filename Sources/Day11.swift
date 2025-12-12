// Copyright © 2025 Brent Tunnicliff <brent@tunnicliff.dev>

import AOCHelper
import Algorithms
import Foundation

/// <https://adventofcode.com/2025/day/11>.
struct Day11: AdventDay {
    let data: String

    private var serverRack: ServerRack {
        let rows = data.split(separator: "\n")
        var values: [String: [String]] = [:]
        for row in rows {
            let splitOne = row.split(separator: ": ").map { $0.toString() }
            precondition(splitOne.count == 2)
            let device = splitOne[0]
            let outputs = splitOne[1].split(separator: " ").map { $0.toString() }
            values[device] = outputs
        }

        return ServerRack(values: values)
    }

    func part1() -> Int {
        calculatePaths(
            device: "you",
            serverRack: serverRack,
            history: ["you"]
        )
    }

    private func calculatePaths(
        device: String,
        serverRack: ServerRack,
        history: [String]
    ) -> Int {
        let outputs = serverRack[device]
        var result = 0

        // if we have looped then ignore.
        for output in outputs ?? [] where !history.contains(output) {
            guard output != "out" else {
                result += 1
                continue
            }

            result += calculatePaths(
                device: output,
                serverRack: serverRack,
                history: history + [device]
            )
        }

        return result
    }
}

/// Making it a class so it is a reference instead of a value.
private final class ServerRack {
    private let values: [String: [String]]

    init(values: [String: [String]]) {
        self.values = values
    }

    subscript(_ key: String) -> [String]? {
        values[key]
    }
}
