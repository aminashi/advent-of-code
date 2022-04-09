import Foundation

enum Operations: String, CaseIterable {
    case and = "AND"
    case or = "OR"
    case lshift = "LSHIFT"
    case rshift = "RSHIFT"
    case not = "NOT"
    
    func execute(_ equation: [UInt16]) -> UInt16 {
        switch self {
        case .not: return ~equation[0]
        case .and: return equation[0]&equation[1]
        case .or: return equation[0]|equation[1]
        case .lshift: return equation[0]<<equation[1]
        case .rshift: return equation[0]>>equation[1]
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
    
    var elements: [String : UInt16] = [:]
    
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
                var equationList: [UInt16] = []
                if let val1 = elements[equationString[0]] {
                    equationList.append(UInt16(val1))
                }
                
                if let val2 = elements[equationString[1]] {
                    equationList.append(UInt16(val2))
                } else {
                    equationList.append(UInt16(equationString[1])!)
                }
                
                elements[newElement] = operation.execute(equationList)
                break
            }
        }
        
        if currentOperator == nil {
            elements[newElement] = UInt16(equation)!
        }
    }
    print(elements)
    
}
