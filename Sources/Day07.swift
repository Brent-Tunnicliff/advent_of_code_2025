// Copyright © 2025 Brent Tunnicliff <brent@tunnicliff.dev>

import AOCHelper
import Algorithms

struct Day07: AdventDay {
    let data: String
    private let startPosition = "S"
    private let emptySpace = "."
    private let beam = "|"
    private let splitter = "^"

    private var grid: ImmutableGrid<Coordinates, String> {
        ImmutableGrid(data: data)
    }

    func part1() -> Int {
        var grid = self.grid.values
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

    func part2() -> Int {
        let gird = self.grid
        guard let startingPosition = grid.values.first(where: { $0.value == startPosition })?.key else {
            preconditionFailure("No starting position")
        }

        let cache = SimpleCache<Coordinates, Int>()
        return possibleTimelines(position: startingPosition.next(in: .south), gird: gird, cache: cache)
    }

    private func possibleTimelines(
        position: Coordinates,
        gird: ImmutableGrid<Coordinates, String>,
        cache: SimpleCache<Coordinates, Int>
    ) -> Int {
        if let cachedValue = cache[position] {
            return cachedValue
        }

        let result: Int
        switch gird[position] {
        case emptySpace:
            result = possibleTimelines(
                position: position.next(in: .south),
                gird: gird.adding([position: beam]),
                cache: cache
            )
        case splitter:
            let westResult = possibleTimelines(
                position: position.next(in: .west),
                gird: gird.adding([position: beam]),
                cache: cache
            )
            let eastResult = possibleTimelines(
                position: position.next(in: .east),
                gird: gird.adding([position: beam]),
                cache: cache
            )
            result = westResult + eastResult
        case nil:
            // If we get to the bottom then we count it.
            result = 1
        default:
            result = 0
        }

        cache[position] = result

        return result
    }
}
