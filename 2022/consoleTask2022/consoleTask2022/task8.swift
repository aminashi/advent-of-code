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
            
                visibleTrees += 1
                print("\(rowIndex), \(columnIndex), \(tree), \(row[columnIndex - 1] < tree) \(row[columnIndex + 1] < tree) \(grid[rowIndex-1][columnIndex] < tree) \(grid[rowIndex+1][columnIndex] < tree)")
            }
            
        }
    }
    
    print(visibleTrees)
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
