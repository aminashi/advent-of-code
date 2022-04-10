import Foundation

enum Navigation: Character {
    case left = "<"
    case down = "v"
    case up = "^"
    case right = ">"

    func move() -> (x: Int, y: Int) {
        switch self {
        case .left:
            return (-1, 0)
        case .down:
            return (0, -1)
        case .up:
            return (0, 1)
        case .right:
            return (1, 0)
        }
    }
}

struct Coordinates: Hashable {
    let x: Int
    let y: Int

    init(tuple: (x: Int, y: Int)) {
        x = tuple.x
        y = tuple.y
    }

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

func task3() {
    var houses: Dictionary<Coordinates, Int> = [Coordinates(x: 0, y: 0): 1]

    var SantaCurrentPosition = (x: 0, y: 0)
    var RoboSantaCurrentPosition = (x: 0, y: 0)

    let navigation = "^v^v"

    for (instruction, move) in navigation.enumerated() {
        if let next = Navigation(rawValue: move) {
            let nextMove = next.move()
            if instruction%2 == 0 {
                SantaCurrentPosition = (SantaCurrentPosition.x + nextMove.x, SantaCurrentPosition.y + nextMove.y)
                houses[Coordinates(tuple: SantaCurrentPosition)] = 1
            } else {
                RoboSantaCurrentPosition = (RoboSantaCurrentPosition.x + nextMove.x, RoboSantaCurrentPosition.y + nextMove.y)
                houses[Coordinates(tuple: RoboSantaCurrentPosition)] = 1
            }
        }
    }

    print("Number of visiter houses (at least once): \(houses.count)")
}
