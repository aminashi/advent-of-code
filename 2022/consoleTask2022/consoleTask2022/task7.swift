import Foundation

extension Advent {
    private enum Command {
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
    
    private class Directory {
        var name: String
        var directories: [Directory]
        var files: [File]
        var size: Int
        var parent: Directory?
        
        init(name: String, parent: Directory? = nil) {
            self.name = name
            self.directories = []
            self.files = []
            self.size = 0
            self.parent = parent
        }
    }
    
    private class File {
        var name: String
        var size: Int
        
        init(name: String, size: Int) {
            self.name = name
            self.size = size
        }
    }
    
    func task7(part: Part) {
        
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
                        pointing = pointing?.directories.first(where: {$0.name == name})
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
                let elementData = line.components(separatedBy: " ")
                if elementData[0] == "dir" {
                    let directory = Directory(name: elementData[1], parent: pointing)
                    pointing?.directories.append(directory)
                } else {
                    let file = File(name: elementData[1], size: Int(elementData[0])!)
                    pointing?.files.append(file)
                }
            }
        }
        
        updateSize(directory: structure!)
        
        if case .first = part {
            print(findDirectories(directory: structure!))
        } else {
            let freeSpace = 70000000 - structure!.size
            if freeSpace < 30000000 {
                print(findDirectorySizeToRemove(directory: structure!, freeSpace: freeSpace))
            }
        }
        
    }
    
    private func findDirectories(directory: Directory) -> Int {
        var size = 0
        
        directory.directories.forEach({ directory in
            size += findDirectories(directory: directory)
            if directory.size <= 100000 {
                size += directory.size
            }
        })
        
        return size
    }
    
    private func findDirectorySizeToRemove(directory: Directory, freeSpace: Int) -> Int {
        var maxSize: Int = 70000000
        
        directory.directories.forEach({ directory in
            let nestedSize = findDirectorySizeToRemove(directory: directory, freeSpace: freeSpace)
            if freeSpace + nestedSize >= 30000000 && nestedSize < maxSize {
                maxSize = nestedSize
            } else if freeSpace + directory.size >= 30000000 && directory.size < maxSize {
                maxSize = directory.size
            }
        })
        
        return maxSize
    }
    
    private func updateSize(directory: Directory) {
        
        var size = directory.files.reduce(0) { $0 + $1.size }
        
        directory.directories.forEach({ directory in
            updateSize(directory: directory)
            size += directory.size
        })
        
        directory.size = size
    }
}
