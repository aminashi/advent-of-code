import Foundation

func task8() {
    
    let grid: [[Int]] = """
    30373
    25512
    65332
    33549
    35390
    """.components(separatedBy: "\n").map{ line in
        line.compactMap({ Int(String($0)) })
    }
    
    var visibleTrees = 4*(grid.count-1)
    
    for (rowIndex, row) in grid.enumerated() {
        if rowIndex == 0 || rowIndex == grid.count - 1 {
            continue
        }
        
        for (columnIndex, tree) in row.enumerated() {
            if columnIndex == 0 || columnIndex == row.count - 1 {
                continue
            }
            
            var directions: [Direction : Bool] = [
                .left   : false,
                .right  : false,
                .top    : false,
                .bottom : false
            ]
            
            for direction in directions.keys {
                directions[direction] = checkTreesInLine(direction: direction, grid: grid, coordinates: (row: rowIndex, column: columnIndex), tree: tree)
            }
            
            if directions.values.reduce(false, { x, y in
                x || y
            }) == true {
                visibleTrees += 1
            }
            
        }
    }
    
    print(visibleTrees)
}

func checkTreesInLine(direction: Direction, grid: [[Int]], coordinates: (row: Int, column: Int), tree: Int) -> Bool {
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


enum Direction {
    case left
    case right
    case top
    case bottom
    
    func row() -> Int {
        switch self {
        case .left: return -1
        case .right: return 1
        default: return 0
        }
    }
    
    func column() -> Int {
        switch self {
        case .top: return -1
        case .bottom: return 1
        default: return 0
        }
    }
}
