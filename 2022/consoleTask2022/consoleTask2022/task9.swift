import Foundation

extension Advent {
    func task9(part: Part) {
        let input = Number.nine.input.components(separatedBy: "\n")
        
        if case part: Part = .first {
            var headPosition: Point = Point(x: 0, y: 0)
            var tailPosition: Point = Point(x: 0, y: 0)
            var tailPath: [Point: Bool] = [Point(x: 0, y: 0) : true]
            
            for line in input {
                let instruction = line.components(separatedBy: " ")
                if let direction = Instruction(rawValue: instruction[0]), let steps = Int(instruction[1]) {
                    for _ in 0...steps-1 {
                        var newHeadPosition = headPosition.move(to: direction)
                        if (!tailPosition.isInRange(of: newHeadPosition)) {
                            tailPosition = headPosition
                            tailPath[tailPosition] = true
                        }
                        headPosition = newHeadPosition
                    }
                }
            }
            
            print(tailPath.count)
        }
    }
}

enum Instruction: String {
    case R
    case L
    case U
    case D
}

struct Point: Hashable {
    var x: Int
    var y: Int
    
    func move(to direction: Instruction) -> Point {
        switch direction {
        case .D: return Point(x: self.x - 1, y: self.y)
        case .U: return Point(x: self.x + 1, y: self.y)
        case .L: return Point(x: self.x, y: self.y - 1)
        case .R: return Point(x: self.x, y: self.y + 1)
        }
    }
    
    func isInRange(of point: Point) -> Bool {
        if (point.x - self.x)*(point.x - self.x) > 1 || (point.y - self.y)*(point.y - self.y) > 1 {
            return false
        }
        return true
    }
}
