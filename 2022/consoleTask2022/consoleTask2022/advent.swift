import Foundation

public enum Part {
    case first
    case second
}

public enum Number: CaseIterable {
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
}

public protocol AdventProtocol {
    func task(number: Number, part: Part)
}

public class Advent: AdventProtocol {
    public func task(number: Number, part: Part) {
        switch number {
            case .one: return task1(part: part)
        case .two: return task2(part: part)
        case .three: return task3(part: part)
        case .four: return task4(part: part)
        case .five: return task5(part: part)
        case .six: return task6(part: part)
        case .seven: return task7(part: part)
        case .eight: return task8(part: part)
        }
    }
}
