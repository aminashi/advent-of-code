import Foundation

extension Advent {
    func task1(part: Part) {
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

        switch part {
        case .first:
            if let max = results.max() {
                print(max)
            }
        case .second:
            results = results.sorted { $0 > $1 }
            if results.count > 2 {
                print(results[0] + results[1] + results[2])
            }
        }
    }
}
