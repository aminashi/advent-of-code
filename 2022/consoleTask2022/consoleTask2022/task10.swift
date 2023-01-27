import Foundation

extension Advent {
    private class Task10 {
        var signalStrength: [Int] = []
        
        var value: Int = 1
        
        var cycle: Int = 1 {
            didSet {
                if cycle == 20 || cycle == 60 || cycle == 100 || cycle == 140 || cycle == 180 || cycle == 220 {
                    signalStrength.append(value*cycle)
                }
            }
        }
    }
    
    func task10(part: Part) {
        let input = Number.ten.input.components(separatedBy: "\n")
        
        let task10 = Task10()
        
        for line in input {
            let cpuInstruction = CPUInstruction(line: line)
            
            if case .noop = cpuInstruction {
                task10.cycle += 1
            }
            
            if case let .addx(value) = cpuInstruction {
                task10.cycle += 1
                task10.value += value
                task10.cycle += 1
            }
            
            if task10.cycle == 220 {
                break
            }
        }
        
        print(task10.signalStrength)
        print(task10.signalStrength.reduce(0, { return $0 + $1 }))
    }
    
    enum CPUInstruction {
        case addx(value: Int)
        case noop
        
        init?(line: String) {
            if line == "noop" {
                self = CPUInstruction.noop
            } else {
                let match = line.firstMatch(of: /addx (-?\d+)/)
                self = CPUInstruction.addx(value: Int(match!.output.1)!)
            }
        }
        
        func rawValue() -> String {
            switch self {
            case .noop: return "noop"
            case .addx(let value): return "addx \(value)"
            }
        }
    }
}


