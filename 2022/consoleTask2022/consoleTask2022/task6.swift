import Foundation

func task6() {
    
    let input = """
    mjqjpqmgbljsphdztnvjfqwrcgsmlb
    bvwbjplbgvbhsrlpgdmjqwftvncz
    nppdvjthqldpwncqszvftbrmjlhg
    nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg
    zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw
    """.components(separatedBy: "\n")

    let windowSize = 4
    
    for line in input {
        var loopCount = 0
        var uniqueLetters: Set = Set<Character>()
        while uniqueLetters.count != 4 {
            let startIndex = line.index(line.startIndex, offsetBy: loopCount)
            let endIndex = line.index(line.startIndex, offsetBy: windowSize + loopCount - 1)
            var window = String(line[startIndex...endIndex])
            uniqueLetters = Set(window)
            loopCount += 1
        }
        print(loopCount+3)
    }
}
