import Foundation

enum Operations: String, CaseIterable {
    case and = "AND"
    case or = "OR"
    case lshift = "LSHIFT"
    case rshift = "RSHIFT"
    case not = "NOT"
    
    func execute(_ equation: [Int]) -> Int {
        switch self {
        case .not: return equation[0] * 2
        case .and: return equation.reduce(0, {$0+$1})
        case .or: return equation.reduce(0, {$0-$1})
        case .lshift: return equation.reduce(0, {$0/$1})
        case .rshift: return equation.reduce(0, {$0&$1})
        }
    }
    
    var separator: String {
        switch self {
        case .not: return "\(self.rawValue) "
        default: return " \(self.rawValue) "
        }
    }
}

func task7() {
    let circuit = """
    123 -> x
    456 -> y
    x AND y -> d
    x OR y -> e
    x LSHIFT 2 -> f
    y RSHIFT 2 -> g
    NOT x -> h
    NOT y -> i
    """.components(separatedBy: "\n")
    
    var elements: [String : Int] = [:]
    
    for line in circuit {
        let data = line.components(separatedBy: " -> ")
        let newElement = data.last!
        let equation = data.first!
        print(equation)
        var currentOperator: Operations?
        for operation in Operations.allCases {
            if (equation.contains(operation.separator)) {
                var equationString = equation.components(separatedBy: operation.separator)
                currentOperator = operation
                var equationList: [Int] = []
                if let val1 = elements[equationString[0]] {
                    equationList.append(Int(val1))
                }
                
                if let val2 = elements[equationString[1]] {
                    equationList.append(Int(val2))
                }
                
                elements[newElement] = operation.execute(equationList)
                break
            }
        }
        
        if currentOperator == nil {
            elements[newElement] = Int(equation)!
        }
    }
    print(elements)
    
}
