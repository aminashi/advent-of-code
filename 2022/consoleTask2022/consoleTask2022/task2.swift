import Foundation

enum Game: Int {
    case rock = 1
    case paper = 2
    case scissors = 3
    
    //Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock
    func win() -> Game {
        switch self {
        case .rock : return .scissors
        case .scissors: return .paper
        case .paper : return .rock
        }
    }
    
    //0 if you lost, 3 if the round was a draw, and 6 if you won
    func against(opponent: Game) -> Int {
        if opponent.win() == self {
            return 0
        } else if self.win() == opponent {
            return 6
        }
        return 3
    }
    
    //A for Rock, B for Paper, and C for Scissors
    //X for Rock, Y for Paper, and Z for Scissors
    init?(value: String) {
        if value == "A" || value == "X" {
            self = .rock
        } else if value == "B" || value == "Y" {
            self = .paper
        } else if value == "C" || value == "Z" {
            self = .scissors
        }  else {
            return nil
        }
    }
}

func task2(part: Part) {
    let input = """
    A Y
    B X
    C Z
    """.components(separatedBy: "\n")
    
    var score = 0
    
    for roundString in input {
        let round: [String] = roundString.components(separatedBy: " ")
        if let opponent = Game(value: round[0]), let me = Game(value: round[1]) {
            score += me.against(opponent: opponent) + me.rawValue
        }
    }
    print(score)
}
