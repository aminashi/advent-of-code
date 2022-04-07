import Foundation

enum Instruction: String {
    case on = "turn on"
    case off = "turn off"
    case toggle = "toggle"
    
    var drop: Int {
        return self.rawValue.count + 1
    }
    
    func action(light: Int) -> Int {
        switch self {
        case .on: return light + 1
        case .off: return light > 0 ? light - 1 : 0
        case .toggle: return light + 2
        }
    }
}

func task6() {
    //0,0, 0,999, 999,999, and 999,0
    
    var lights = [[Int]](
        repeating: [Int](repeating: 0, count: 1000),
     count: 1000)
    
    var inputs = """
    turn on 0,0 through 999,999
    toggle 0,0 through 999,0
    turn off 499,499 through 500,500
    """.components(separatedBy: "\n")
    
    var instruction: Array<String>
    
    for input in inputs {

        var action: Instruction
    
        if input.starts(with: Instruction.on.rawValue) {
            instruction = String(input.dropFirst(Instruction.on.drop)).components(separatedBy: " through ")
            action = Instruction.on
        } else if input.starts(with: Instruction.off.rawValue) {
            instruction = String(input.dropFirst(Instruction.off.drop)).components(separatedBy: " through ")
            action = Instruction.off
        } else {
            instruction = String(input.dropFirst(Instruction.toggle.drop)).components(separatedBy: " through ")
            action = Instruction.toggle
        }
    
        let start: Array<Int> = instruction[0].components(separatedBy: ",").map{ return Int($0)! }
        let finish: Array<Int> = instruction[1].components(separatedBy: ",").map{ return Int($0)! }
    
        for x in start[0]...finish[0] {
            for y in start[1]...finish[1] {
               lights[x][y] = action.action(light: lights[x][y])
            }
        }
    }
    print(lights.flatMap{$0}.reduce(0, {$0 + $1}))
}
