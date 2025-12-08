// Copyright © 2025 Brent Tunnicliff <brent@tunnicliff.dev>

import AOCHelper
import Algorithms

/// <https://adventofcode.com/2025/day/4>.
struct Day04: AdventDay {
    let data: String
    private let neighboringToiletPaperCountLimit = 4
    private let toiletPaper = "@"

    private var grid: ImmutableGrid<Coordinates, String> {
        ImmutableGrid(data: data)
    }

    func part1() -> Int {
        getAccessibleForkLiftCount(
            grid: grid,
            removeFromGridWhenCounted: false
        ).result
    }

    func part2() -> Int {
        var latestGrid = grid
        var result = 0
        while true {
            let (count, newGrid) = getAccessibleForkLiftCount(
                grid: latestGrid,
                removeFromGridWhenCounted: true
            )

            // If no more results then break
            guard count > 0 else {
                break
            }

            result += count
            latestGrid = newGrid
        }

        return result
    }

    private func getAccessibleForkLiftCount(
        grid: ImmutableGrid<Coordinates, String>,
        removeFromGridWhenCounted: Bool
    ) -> (result: Int, grid: ImmutableGrid<Coordinates, String>) {
        var result = 0
        var grid = grid
        for (coordinates, value) in grid.values where value == toiletPaper {
            let neighbors = product(
                [coordinates.x - 1, coordinates.x, coordinates.x + 1],
                [coordinates.y - 1, coordinates.y, coordinates.y + 1],
            ).map(Coordinates.init)

            var neighboringToiletPaperCount = 0
            for neighbor in neighbors where neighbor != coordinates && grid[neighbor] == toiletPaper {
                neighboringToiletPaperCount += 1

                if neighboringToiletPaperCount >= neighboringToiletPaperCountLimit {
                    break
                }
            }

            if neighboringToiletPaperCount < neighboringToiletPaperCountLimit {
                result += 1

                if removeFromGridWhenCounted {
                    grid = grid.removing(keys: [coordinates])
                }
            }
        }

        return (result, grid)
    }
}
