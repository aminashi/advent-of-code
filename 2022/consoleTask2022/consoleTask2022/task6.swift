import Foundation

extension Advent {
    func task6(part: Part) {
        let input = Number.six.input.components(separatedBy: "\n")
        
        let windowSize = (part == .first) ? 4 : 14
        
        for line in input {
            var loopCount = 0
            var uniqueLetters: Set = Set<Character>()
            while uniqueLetters.count != windowSize {
                let startIndex = line.index(line.startIndex, offsetBy: loopCount)
                let endIndex = line.index(line.startIndex, offsetBy: windowSize + loopCount - 1)
                let window = String(line[startIndex...endIndex])
                uniqueLetters = Set(window)
                loopCount += 1
            }
            print(loopCount + windowSize-1)
        }
    }
}
