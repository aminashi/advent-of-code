import Foundation


func task9() {
    let input = #"""
    London to Dublin = 464
    London to Belfast = 518
    Dublin to Belfast = 141
    """#.split(whereSeparator: \.isNewline)
    
    var graph: [String: [String: Int]] = [:]
    
    for line in input {
        var array: [String] = []
        let splitLines = line.components(separatedBy: " to ")
        array.append(splitLines[0])
        array.append(contentsOf: splitLines[1].components(separatedBy: " = "))
        
        if graph[array[0]] == nil {
            graph[array[0]] = [array[1] : Int(array[2])!]
        } else {
            graph[array[0]]![array[1]] = Int(array[2])!
        }
            
        if graph[array[1]] == nil {
            graph[array[1]] = [array[0] : Int(array[2])!]
        } else {
            graph[array[1]]![array[0]] = Int(array[2])!
        }
    }
    print(graph)
    
}
