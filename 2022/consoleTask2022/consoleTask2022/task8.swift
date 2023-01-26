import Foundation

extension Advent {
    private enum Direction: CaseIterable {
        case left
        case right
        case top
        case bottom
        
        func row() -> Int {
            switch self {
            case .top: return -1
            case .bottom: return 1
            default: return 0
            }
        }
        
        func column() -> Int {
            switch self {
            case .left: return -1
            case .right: return 1
            default: return 0
            }
        }
    }
    
    func task8(part: Part) {
        let grid: [[Int]] = Number.eight.input.components(separatedBy: "\n").map{ line in
            line.compactMap({ Int(String($0)) })
        }
        
        switch part {
        case .first:
            var visibleTrees = 4*(grid.count-1)
            
            for (rowIndex, row) in grid.enumerated() {
                if rowIndex == 0 || rowIndex == grid.count - 1 {
                    continue
                }
                
                for (columnIndex, tree) in row.enumerated() {
                    if columnIndex == 0 || columnIndex == row.count - 1 {
                        continue
                    }
                    
                    var visibilityFromTree = false
                    
                    for direction in Direction.allCases {
                        visibilityFromTree = visibilityFromTree || checkTreesInLine(direction: direction, grid: grid, coordinates: (row: rowIndex, column: columnIndex), tree: tree)
                    }
                    
                    if visibilityFromTree {
                        visibleTrees += 1
                    }
                }
            }
            
            print(visibleTrees)
        case .second:
            var highestScenicScore: Int = 0

            for (rowIndex, row) in grid.enumerated() {
                
                if rowIndex == 0 || rowIndex == grid.count - 1 {
                    continue
                }

                for (columnIndex, tree) in row.enumerated() {
                    var score: Int = 1
                    
                    if columnIndex == 0 || columnIndex == row.count - 1 {
                        continue
                    }

                    for direction in Direction.allCases {
                        score *= calculateScenicScore(in: direction, for: tree, grid: grid, coordinates: (row: rowIndex, column: columnIndex))
                    }
                    
                    if highestScenicScore < score {
                        highestScenicScore = score
                    }
                }
            }
            print(highestScenicScore)
        }
    }
    
    private func calculateScenicScore(in direction: Direction, for tree: Int, grid: [[Int]], coordinates: (row: Int, column: Int)) -> Int {
        
        var scenicScore: Int = 0
        
        if ({
            switch direction {
            case .left: return coordinates.column > 0
            case .right: return coordinates.column < grid.count - 1
            case .top: return coordinates.row > 0
            case .bottom: return coordinates.row < grid.count - 1
            }
        }()) {
            if grid[coordinates.row + direction.row()][coordinates.column + direction.column()] < tree {
                scenicScore += 1 + calculateScenicScore(in: direction, for: tree, grid: grid, coordinates: (row: coordinates.row + direction.row(), column: coordinates.column + direction.column()))
            } else {
                scenicScore += 1
            }
        } else {
            scenicScore += 0
        }
        
        return scenicScore
    }
    
    private func checkTreesInLine(direction: Direction, grid: [[Int]], coordinates: (row: Int, column: Int), tree: Int) -> Bool {
        var visible: Bool = true
        
        if ({
            switch direction {
            case .left: return coordinates.row > 0
            case .right: return coordinates.row < grid.count - 1
            case .top: return coordinates.column > 0
            case .bottom: return coordinates.column < grid.count - 1
            }
        }()) {
            visible = grid[coordinates.row + direction.row()][coordinates.column + direction.column()] < tree
            
            visible = visible && checkTreesInLine(direction: direction, grid: grid, coordinates: (row: coordinates.row + direction.row(), column: coordinates.column + direction.column()), tree: tree)
        }
        
        return visible
    }
}
