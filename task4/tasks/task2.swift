import Foundation

func task2() {
    let boxes = """
    2x3x4
    1x1x10
    """.split(separator: "\n").map{String($0)}

    var ribbon = 0
    
    for box in boxes {
        let dimensions: Array = box.split(separator: "x").map{Int($0)!}.sorted()
        ribbon += 2*dimensions[0] + 2*dimensions[1] + dimensions.reduce(1, { (a,b) in
            a * b})

    }
    
    print(ribbon)
}
