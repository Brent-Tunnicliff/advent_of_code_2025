// Copyright © 2025 Brent Tunnicliff <brent@tunnicliff.dev>

import AOCHelper
import Algorithms
import Foundation

/// <https://adventofcode.com/2025/day/10>.
struct Day10: AdventDay {
    let data: String

    private var machines: [Machine] {
        var machines: [Machine] = []
        // I started trying regex but gave up haha.
        for row in data.trimmingWhitespaces().split(separator: "\n") {
            let firstSplit = row.dropFirst().split(separator: "]")
            var indicatorLightDiagram: [Bool] = []
            for character in firstSplit[0] {
                switch character {
                case ".":
                    indicatorLightDiagram.append(false)
                case "#":
                    indicatorLightDiagram.append(true)
                default:
                    preconditionFailure("Unexpected character '\(character)'")
                }
            }

            let secondSplit = firstSplit[1].dropLast().split(separator: "{")
            var buttonWiringSchematics: [Button] = []
            for buttonConfig in secondSplit[0].trimmingWhitespaces().split(separator: " ") {
                buttonWiringSchematics.append(
                    Button(
                        lightIndexes: buttonConfig.dropFirst()
                            .dropLast()
                            .split(separator: ",")
                            .map { $0.toInt() }
                    )
                )
            }

            machines.append(
                Machine(
                    indicatorLightDiagram: indicatorLightDiagram,
                    buttonWiringSchematics: buttonWiringSchematics
                )
            )
        }

        return machines
    }

    func part1() -> Int {
        let machines = self.machines
        var result = 0

        for (offset, machine) in machines.enumerated() {
            // Runs slowly, so printing to see progress.
            print("machine \(offset)/\(machines.count)")
            let initialState = machine.indicatorLightDiagram.map { _ in false }
            var queue = [QueueData(currentIndicatorLightState: initialState, history: [])]
            var lowestClicks = Int.max
            var sharedHistory: [[Bool]: Int] = [:]
            while true {
                // Seems `removeFirst` is too slow.
                guard !queue.isEmpty else {
                    break
                }
                let currentState = queue.removeFirst()

                // if current state is already higher than lowest, then skip.
                guard currentState.history.count < lowestClicks else {
                    continue
                }

                guard currentState.currentIndicatorLightState != machine.indicatorLightDiagram else {
                    lowestClicks = min(lowestClicks, currentState.history.count)
                    continue
                }

                for button in machine.buttonWiringSchematics {
                    var newState: [Bool] = currentState.currentIndicatorLightState
                    for lightIndex in button.lightIndexes {
                        newState[lightIndex].toggle()
                    }

                    // If we have looped back to an old state then ignore.
                    guard !currentState.history.contains(newState) else {
                        continue
                    }

                    let newHistory = currentState.history + [newState]

                    // If another flow got to the same state faster, then ignore.
                    if let cachedSharedHistory = sharedHistory[newState], cachedSharedHistory < newHistory.count {
                        continue
                    }

                    sharedHistory[newState] = newHistory.count

                    // Add the new state to the queue.
                    queue.append(
                        QueueData(
                            currentIndicatorLightState: newState,
                            history: newHistory
                        )
                    )
                }
            }

            result += lowestClicks
        }

        return result
    }

//    func part2() -> Int {
//        -1
//    }
}

private struct Machine {
    let indicatorLightDiagram: [Bool]
    let buttonWiringSchematics: [Button]

    // Maybe for part 2?
    // let joltageRequirements: [Int]
}

private struct Button {
    let lightIndexes: [Int]
}

private struct QueueData {
    let currentIndicatorLightState: [Bool]
    let history: [[Bool]]
}
