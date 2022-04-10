import CryptoKit
import Foundation

func task4() {
    let secret = "iwrupvqb"

    //If your secret key is abcdef, the answer is 609043, because the MD5 hash of abcdef609043 starts with five zeroes (000001dbbfa...), and it is the lowest such number to do so.

    var found = false
    var number = -1
    var string: String = ""
    var hashmd5: Insecure.MD5.Digest
    var hashString: String

    while (!found)
    {
        (number = number + 1)
        (string = "\(secret)\(number)")
        (hashmd5 = Insecure.MD5.hash(data: Data(string.utf8)))
        (hashString = hashmd5.map { String(format: "%02hhx", $0)}.joined())
        (found = hashString.starts(with: "00000"))
    }

    print("the number is: \(number)")
}
