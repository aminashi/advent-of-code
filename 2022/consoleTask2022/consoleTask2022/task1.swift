import Foundation

func task1() {
    let input = """
    1000
    2000
    3000

    4000

    5000
    6000

    7000
    8000
    9000

    10000
    """.components(separatedBy: "\n")
    
    var results: [Int] = [0]
    var index: Int = 0
    
    for element in input {
        if element.isEmpty {
            index += 1
            results.append(0)
        } else {
            results[index] += Int(element)!
        }
    }

    if let max = results.max() {
        print(max)
    }
}
