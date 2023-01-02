import Foundation

extension Advent {
    @available(macOS 13, *)
    func task4(part: Part) {
        let input = Number.four.input.components(separatedBy: "\n")
        
        var result = 0
        let regex = /(\d+)\-(\d+)\,(\d+)\-(\d+)/
        for pair in input {
            if let match = pair.wholeMatch(of: regex) {
                if let one = Int(match.1), let two = Int(match.2), let three = Int(match.3), let four = Int(match.4) {
                    switch part {
                    case .first:
                        if (one >= three && two <= four) || (three >= one && four <= two) {
                            result += 1
                        }
                    case .second:
                        if (one <= two && two < three && three <= four) || (three <= four && four < one && one <= two) {
                            continue
                        } else {
                            result += 1
                        }
                    }
                }
            }
        }
        print(result)
    }
}
