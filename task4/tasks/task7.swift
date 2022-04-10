import Foundation

enum Operator: String, CaseIterable {
    case and = "AND"
    case or = "OR"
    case lshift = "LSHIFT"
    case rshift = "RSHIFT"
    case not = "NOT"
    case equal = ""
    
    func execute(_ equation: Calculation) -> UInt16 {
        switch self {
        case .not: return ~equation.right!
        case .and: return equation.left! & equation.right!
        case .or: return equation.left! | equation.right!
        case .lshift: return equation.left! << equation.right!
        case .rshift: return equation.left! >> equation.right!
        case .equal: return equation.left!
        }
    }
    
    var separator: String {
        switch self {
        case .not: return "\(self.rawValue) "
        default: return " \(self.rawValue) "
        }
    }
}

struct Element {
   var left: String?
   var right: String?
   var operation: Operator
}


struct Calculation {
   var left: UInt16?
   var right: UInt16?
   var operation: Operator
}


class Task7 {
    let circuit: [[String]]
    var data: [String:Element] = [:]
    
    init(circuit: String) {
        self.circuit = circuit.components(separatedBy: "\n").map{ return $0.components(separatedBy: " -> ")}
    }
    
    func orderData() {
        for line in circuit {
            let equation = line[0].components(separatedBy: " ")
            if equation.count == 3 {
                if let currentOperation = Operator(rawValue: equation[1]) {
                    data[line[1]] = Element(left: equation[0], right: equation[2], operation: currentOperation)
                }
            } else if equation.count == 2 {
                if let currentOperation = Operator(rawValue: equation[0]) {
                    data[line[1]] = Element(left: nil, right: equation[1], operation: currentOperation)
                }
            } else {
                data[line[1]] = Element(left: equation[0], right: nil, operation: .equal)
            }
        }
    }
    
    var lookup: [String : UInt16] = [:]
    
    func find(for wire: String) -> UInt16? {
        
        guard let element = data[wire] else {
            return nil
        }
        
//        if let stringValue = element.left, let value = UInt16(stringValue) {
//            lookup[wire] = value
//            return lookup[wire]
//        }
        
        var calculation: Calculation = Calculation(left: nil, right: nil, operation: element.operation)
        
        if let left = element.left {
            if let value = UInt16(left) {
                calculation.left = value
            } else {
                if let calculatedLeft = lookup[left] {
                    calculation.left = calculatedLeft
                } else {
                    calculation.left = find(for: left)
                }
            }
        }
        
        if let right = element.right {
            if let value = UInt16(right) {
                calculation.right = value
            } else {
                 if let calculatedRight = lookup[right] {
                     calculation.right = calculatedRight
                 } else {
                    calculation.right = find(for: right)
                 }
            }
        }
        
        lookup[wire] = calculation.operation.execute(calculation)
        return lookup[wire]
    }
}
