import Foundation

extension Advent {
    func task9(part: Part) {
        let input = Number.nine.input.components(separatedBy: "\n")
        for line in input {
            let instruction = line.components(separatedBy: " ")
            if let direction = Instruction(rawValue: instruction[0]) {
                
            }
        }
    }
}

enum Instruction: String {
    case R
    case L
    case U
    case D
}
