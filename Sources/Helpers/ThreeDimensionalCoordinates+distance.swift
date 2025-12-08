// Copyright © 2025 Brent Tunnicliff <brent@tunnicliff.dev>

import AOCHelper

// TODO: Move to `AOCHelper`
extension ThreeDimensionalCoordinates {
    /// Calculates distance using `Euclidean distance`.
    func distance(to other: ThreeDimensionalCoordinates) -> Int {
        let dx = other.x - x
        let dy = other.y - y
        let dz = other.z - z
        return Int(Double(dx * dx + dy * dy + dz * dz).squareRoot())
    }
}
