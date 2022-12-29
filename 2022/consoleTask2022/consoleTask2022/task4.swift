import Foundation

@available(macOS 13, *)
func task4(part: Part) {
    let input = """
    2-4,6-8
    2-3,4-5
    5-7,7-9
    2-8,3-7
    6-6,4-6
    2-6,4-8
    """.components(separatedBy: "\n")
    
    var result = 0
    let regex = /(\d+)\-(\d+)\,(\d+)\-(\d+)/
    for pair in input {
        if let match = pair.wholeMatch(of: regex) {
            if let one = Int(match.1), let two = Int(match.2), let three = Int(match.3), let four = Int(match.4) {
                switch part {
                case .one:
                    if (one >= three && two <= four) || (three >= one && four <= two) {
                        result += 1
                    }
                case .two:
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



// a c b d
// a c d b
// c a d b
// c a b d

//a b c d
//c d a b