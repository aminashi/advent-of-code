import Foundation

func task8() {
    
    let a = #"""
"\""
"\\\""
"\\\xab"
"""#
    print(a)

    let b = a.split(whereSeparator: \.isNewline)
    
    var result = 0
    
    for line in b {
        let count = line.utf8.count
        print(count)
        let ascii = line.replacingOccurrences(
            of: #"\\x.."#,
            with: "S",
            options: .regularExpression
        )
        
        let doubleQuote = ascii.replacingOccurrences(
            of: #"\\\\"#,
            with: "Q",
            options: .regularExpression
        )
        
        let escaped = doubleQuote.replacingOccurrences(
            of: #"\\""#,
            with: "E",
            options: .regularExpression
        )
        let countReplaced = escaped.utf8.count-2
        print(countReplaced)
        result += (count - countReplaced)
        print(result)
    }
    
    print(result)
}
