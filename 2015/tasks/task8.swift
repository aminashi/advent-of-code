import Foundation

func task8() {
//    Santa's list is a file that contains many double-quoted string literals, one on each line. The only escape sequences used are \\ (which represents a single backslash), \" (which represents a lone double-quote character), and \x plus two hexadecimal characters (which represents a single character with that ASCII code).
    
    
    let a = "aaa\"aaa"
    let b = #"aaa\"aaa"#
    
    print(a.count)
    print(b.count+2)
    
    let c = "\u{27}"
    let d = #"\x27"#
    
    print(c.count)
    print(c)
    print(d.count+2)
    
    let e = "byc\u{9d}yxuafof\\\u{a6}uf\\axfozomj\\olh\u{6a}"
    let f = #"byc\x9dyxuafof\\\xa6uf\\axfozomj\\olh\x6a"#
    
    print(e)
    print(f.count)
}
