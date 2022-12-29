import Foundation

func task5() {
    
    let input = """
        [D]
    [N] [C]
    [Z] [M] [P]
     1   2   3

    move 1 from 2 to 1
    move 3 from 1 to 3
    move 2 from 2 to 1
    move 1 from 1 to 2
    """.components(separatedBy: "\n\n")
    
    var cratesString = input[0].components(separatedBy: "\n")
    
    let regex = /\s(\d+)\s?/
    guard let crateNumbers = cratesString.last?.matches(of: regex) else {
        print("no crates")
        return
    }
    cratesString.removeLast()
    let lineSize = crateNumbers.count * 3 + crateNumbers.count - 1
    
    var crates: [Int:[String]] = [:]
    
    for line in cratesString.reversed() {
        let start = line.startIndex
        var offset = 4
        var loopCount = 0
        while loopCount * offset <= lineSize {
            var value = "   "
            if offset * loopCount + 2 <= line.count - 1 {
                let startSubString = line.index(line.startIndex, offsetBy: offset * loopCount)
                let endSubString = line.index(line.startIndex, offsetBy: offset * loopCount + 2)
                value = String(line[startSubString...endSubString])
            }
            if value == "   " {
                loopCount += 1
                continue
            }
            if crates[loopCount+1] != nil {
                crates[loopCount+1]!.append(value)
            } else {
                crates[loopCount+1] = [value]
            }
            loopCount += 1
        }
    }
    
    let instructions = input[1].components(separatedBy: "\n")
    let regex2 = /move (\d) from (\d) to (\d)/
    
    for instructionString in instructions {
        if let instruction = instructionString.wholeMatch(of: regex2) {
            if let howMany = Int(instruction.1), let from = Int(instruction.2), let to = Int(instruction.3) {
                for _ in 1...howMany {
                    if let value = crates[from]?.popLast() {
                        crates[to]?.append(value)
                    }
                }
            }
            print(crates)
        }
    }
    
}
