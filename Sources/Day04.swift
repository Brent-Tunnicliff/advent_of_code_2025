// Copyright © 2025 Brent Tunnicliff <brent@tunnicliff.dev>

import AOCHelper
import Algorithms

struct Day04: AdventDay {
    let data: String
    private let toiletPaper = "@"

    private var grid: Grid<Coordinates, String> {
        Grid(data: data)
    }

    func part1() -> Int {
        let neighboringToiletPaperCountLimit = 4
        let grid = grid
        var result = 0
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
            }
        }

        return result
    }

//    func part2() -> Int {
//        
//    }
}
