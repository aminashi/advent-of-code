import Foundation

enum GameOne: Int {
    case rock = 1
    case paper = 2
    case scissors = 3
    
    //Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock
    func win() -> GameOne {
        switch self {
        case .rock : return .scissors
        case .scissors: return .paper
        case .paper : return .rock
        }
    }
    
    //0 if you lost, 3 if the round was a draw, and 6 if you won
    func against(opponent: GameOne) -> Int {
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

enum GameTwo: String {
    case rock = "A"
    case paper = "B"
    case scissors = "C"
    
    func score() -> Int {
        switch self {
        case .rock: return 1
        case .paper: return 2
        case .scissors: return 3
        }
    }
    
    //Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock
    func win() -> GameTwo {
        switch self {
        case .rock : return .scissors
        case .scissors: return .paper
        case .paper : return .rock
        }
    }
    
    func lose() -> GameTwo {
        switch self {
        case .rock : return .paper
        case .scissors: return .rock
        case .paper : return .scissors
        }
    }
    
    //X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win
    func expectedResult(hint: String) -> Int {
        if hint == "X" {
            return self.win().score()
        } else if hint == "Z" {
            return self.lose().score() + 6
        } else {
            return self.score() + 3
        }
    }
}

func task2(part: Part) {
    let input = """
    A Y
    B X
    C Z
    """.components(separatedBy: "\n")
    
    switch part {
    case .one:
        var score = 0

        for roundString in input {
            let round: [String] = roundString.components(separatedBy: " ")
            if let opponent = GameOne(value: round[0]), let me = GameOne(value: round[1]) {
                score += me.against(opponent: opponent) + me.rawValue
            }
        }
        print(score)
    case .two:
        var score = 0
        
        for roundString in input {
            let round: [String] = roundString.components(separatedBy: " ")
            if let opponent = GameTwo(rawValue: round[0]) {
                score += opponent.expectedResult(hint: round[1])
            }
        }
        print(score)
    }
}
