import Foundation

extension Advent {
    func task5(part: Part) {
        let input = Number.five.input.components(separatedBy: "\n\n")
        
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
            let offset = 4
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
        let regex2 = /move (\d+) from (\d+) to (\d+)/
        
        for instructionString in instructions {
            if let instruction = instructionString.wholeMatch(of: regex2) {
                if let howMany = Int(instruction.1), let from = Int(instruction.2), let to = Int(instruction.3) {
                    switch part {
                    case .first:
                        for _ in 1...howMany {
                            if let value = crates[from]?.popLast() {
                                crates[to]?.append(value)
                            }
                        }
                    case .second:
                        guard let subsequence = crates[from]?.suffix(howMany) else { return }
                        crates[to]?.append(contentsOf: subsequence)
                        crates[from]?.removeLast(howMany)
                    }
                }
                print(crates)
            }
        }
        
        var result: String = String(repeating: " ", count: crates.count)
        
        for key in crates.keys {
            if let crate = crates[key]?.popLast(), let letter = crate.firstMatch(of: /\[(\w)\]/) {
                let index = result.index(result.startIndex, offsetBy: key-1)
                result.replaceSubrange(index...index, with: letter.output.1)
            }
        }
        print(result)
    }
}
