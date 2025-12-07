// Copyright © 2025 Brent Tunnicliff <brent@tunnicliff.dev>

import AOCHelper
import Algorithms

struct Day07: AdventDay {
    let data: String
    private let startPosition = "S"
    private let emptySpace = "."
    private let beam = "|"
    private let splitter = "^"

    private var grid: [Coordinates: String] {
        Grid(data: data).values
    }

    func part1() -> Int {
        var grid = self.grid
        guard let startingPosition = grid.first(where: { $0.value == startPosition })?.key else {
            preconditionFailure("No starting position")
        }

        var queue: [Coordinates] = [startingPosition.next(in: .south)]
        while !queue.isEmpty {
            guard let position = queue.popLast() else {
                preconditionFailure("No position in queue")
            }

            switch grid[position] {
            case emptySpace:
                grid[position] = beam
                queue.append(position.next(in: .south))
            case splitter:
                queue.append(position.next(in: .west))
                queue.append(position.next(in: .east))
            default:
                break
            }
        }

        return grid.count {
            $0.value == splitter && grid[$0.key.next(in: .north)] == beam
        }
    }

//    func part2() -> Int {
//
//    }
}
