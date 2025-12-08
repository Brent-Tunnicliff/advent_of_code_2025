// Copyright © 2025 Brent Tunnicliff <brent@tunnicliff.dev>

import AOCHelper
import Algorithms
import Foundation

/// <https://adventofcode.com/2025/day/8>.
struct Day08: AdventDay {
    let data: String
    var partOneLimit = 1000

    private var junctionBoxLocations: [ThreeDimensionalCoordinates] {
        var junctionBoxLocations: [ThreeDimensionalCoordinates] = []
        for row in data.trimmingWhitespaces().split(separator: "\n") {
            let parts = row.split(separator: ",").map { $0.toInt() }
            precondition(parts.count == 3, "Unexpected number of parts in \(row)")
            junctionBoxLocations.append(
                ThreeDimensionalCoordinates(
                    x: parts[0],
                    y: parts[1],
                    z: parts[2]
                )
            )
        }

        return junctionBoxLocations
    }

    init(data: String) {
        self.data = data
    }

    func part1() -> Int {
        let limit = partOneLimit
        let junctionBoxLocations = self.junctionBoxLocations
        let allConnections = junctionBoxLocations.enumerated().flatMap { location in
            junctionBoxLocations.dropFirst(location.offset + 1).map {
                Connection(location.element, $0)
            }
        }.sorted(by: { $0.distance < $1.distance })

        let closestConnections = allConnections.dropLast(max(allConnections.count - limit, 0))
        var linkedConnections: [LinkedConnections] = []
        for connection in closestConnections {
            let existingConnections = linkedConnections.filter {
                $0.overlaps(connection: connection)
            }

            guard !existingConnections.isEmpty else {
                linkedConnections.append(LinkedConnections(connections: [connection]))
                continue
            }

            guard existingConnections.count > 1 else {
                existingConnections.first?.add(connection)
                continue
            }

            // merge the connections together
            let firstConnection = existingConnections[0]
            for otherConnection in existingConnections.dropFirst() {
                for connectionToMerge in otherConnection.connections {
                    firstConnection.add(connectionToMerge)
                }

                linkedConnections = linkedConnections.filter {
                    $0.connections != otherConnection.connections
                }
            }
        }

        // get highest 3 counts
        let linkedJunctions = linkedConnections.map { linkedConnection in
            linkedConnection.connections.flatMap {
                [$0.first, $0.second]
            }.toSet()
        }

        let results = linkedJunctions.map(\.count).sorted().dropFirst(max(linkedJunctions.count - 3, 0))
        return results.reduce(into: 1) { partialResult, count in
            partialResult *= count
        }
    }

    func part2() -> Int {
        let junctionBoxLocations = self.junctionBoxLocations
        let allConnections = junctionBoxLocations.enumerated().flatMap { location in
            junctionBoxLocations.dropFirst(location.offset + 1).map {
                Connection(location.element, $0)
            }
        }.sorted(by: { $0.distance < $1.distance })

        var result = 0
        var linkedConnections: [LinkedConnections] = []
        for connection in allConnections {
            let existingConnections = linkedConnections.filter {
                $0.overlaps(connection: connection)
            }

            guard !existingConnections.isEmpty else {
                linkedConnections.append(LinkedConnections(connections: [connection]))
                continue
            }

            if existingConnections.count == 1 {
                existingConnections.first?.add(connection)
            } else {
                // merge the connections together
                let firstConnection = existingConnections[0]
                for otherConnection in existingConnections.dropFirst() {
                    for connectionToMerge in otherConnection.connections {
                        firstConnection.add(connectionToMerge)
                    }

                    linkedConnections = linkedConnections.filter {
                        $0.connections != otherConnection.connections
                    }
                }
            }

            guard
                linkedConnections.count == 1,
                let linkedCoordinates = linkedConnections.first?.connections.flatMap({ [$0.first, $0.second] }).toSet(),
                linkedCoordinates.count == junctionBoxLocations.count
            else {
                continue
            }

            result = connection.first.x * connection.second.x
            break
        }

        return result
    }
}

private struct Connection: Equatable {
    let first: ThreeDimensionalCoordinates
    let second: ThreeDimensionalCoordinates
    let distance: Int

    init(_ first: ThreeDimensionalCoordinates, _ second: ThreeDimensionalCoordinates) {
        self.first = first
        self.second = second
        self.distance = first.distance(to: second)
    }

    func contains(coordinates: ThreeDimensionalCoordinates) -> Bool {
        first == coordinates || second == coordinates
    }
}

private final class LinkedConnections {
    private(set) var connections: [Connection]

    init(connections: [Connection]) {
        self.connections = connections
    }

    func overlaps(connection: Connection) -> Bool {
        connections.contains {
            $0.contains(coordinates: connection.first) || $0.contains(coordinates: connection.second)
        }
    }

    func add(_ connection: Connection) {
        connections.append(connection)
    }
}
