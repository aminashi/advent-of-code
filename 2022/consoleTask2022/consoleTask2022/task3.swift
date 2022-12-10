import Foundation

func task3(part: Part) {
    let input = """
    vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg
    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw
    """.components(separatedBy: "\n")
    
    var priorityScore: Int = 0
    
    for pair in input {
        let rucksackElements: Int = pair.count / 2
        let start = pair.startIndex
        let division = pair.index(start, offsetBy: rucksackElements)
        let end = pair.endIndex
        
        let first = Set(pair[start..<division])
        let second = Set(pair[division..<end])
        
        let duplication = first.intersection(second)

        // a = 097, A = 065
        // Lowercase item types a through z have priorities 1 through 26.
        // Uppercase item types A through Z have priorities 27 through 52.
        if let ascii = duplication.first?.asciiValue {
            if ascii >= 97 {
                priorityScore += Int(ascii-96)
            } else if ascii <= 96 {
                priorityScore += Int(ascii-38)
            }
        }
    }
    print(priorityScore)
}
