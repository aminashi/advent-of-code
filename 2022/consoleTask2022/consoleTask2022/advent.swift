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
    }
}
