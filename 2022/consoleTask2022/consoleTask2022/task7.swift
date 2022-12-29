import Foundation

enum Command {
    case cd(name: String)
    case ls
    case back
    
    init?(line: String) {
        if line == "$ ls" {
            self = Command.ls
        } else if line == "$ cd .." {
            self = Command.back
        } else {
            let match = line.firstMatch(of: /\$ cd (.+)/)
            self = Command.cd(name: String(match!.output.1))
        }
    }
    
    func rawValue() -> String {
        switch self {
        case .cd(let name): return "$ cd \(name)"
        case .ls: return "$ ls"
        case .back: return "$ cd .."
        }
    }
}

protocol Element {
    var name: String { get }
    var size: Int { get }
}

class Directory: Element {
    var name: String
    var elements: [Element]
    var size: Int
    var parent: Directory?
    
    init(name: String, parent: Directory? = nil) {
        self.name = name
        self.elements = []
        self.size = 0
        self.parent = parent
    }
}

class File: Element {
    var name: String
    var size: Int
    
    init(name: String, size: Int) {
        self.name = name
        self.size = size
    }
}

func task7() {
    
    var structure: Directory? = nil
    var pointing: Directory? = nil
    
    let input = """
    $ cd /
    $ ls
    dir a
    14848514 b.txt
    8504156 c.dat
    dir d
    $ cd a
    $ ls
    dir e
    29116 f
    2557 g
    62596 h.lst
    $ cd e
    $ ls
    584 i
    $ cd ..
    $ cd ..
    $ cd d
    $ ls
    4060174 j
    8033020 d.log
    5626152 d.ext
    7214296 k
    """.components(separatedBy: "\n")
    
    for line in input {
        if line.first == "$" {
            let command = Command(line: line)
            if case let .cd(name) = command {
                if structure != nil {
                    pointing = pointing?.elements.first(where: {$0.name == name}) as? Directory
                } else {
                    structure = Directory(name: name)
                    pointing = structure
                }
            }
            if case .ls = command {
                continue
            }
            if case .back = command {
                pointing = pointing?.parent
            }
        } else {
    }
}
}
