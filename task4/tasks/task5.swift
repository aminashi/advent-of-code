import Foundation

func task5() {
    //It contains at least three vowels (aeiou only), like aei, xazegov, or aeiouaeiouaeiou.
    //It contains at least one letter that appears twice in a row, like xx, abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
    //It does not contain the strings ab, cd, pq, or xy, even if they are part of one of the other requirements.

    //ugknbfddgicrmopn is nice because it has at least three vowels (u...i...o...), a double letter (...dd...), and none of the disallowed substrings.
    //aaa is nice because it has at least three vowels and a double letter, even though the letters used by different rules overlap.
    //jchzalrnumimnmhp is naughty because it has no double letter.
    //haegwjzuvuyypxyu is naughty because it contains the string xy.
    //dvszwmarrgswjxmb is naughty because it contains only one vowel.

    var niceStrings = 0
    var words: [String] = """
    ugknbfddgicrmopn
    aaa
    jchzalrnumimnmhp
    haegwjzuvuyypxyu
    dvszwmarrgswjxmb
    """.components(separatedBy: "\n")

    var vowels = "aeiou"
    var illegal = ["ab", "cd", "pq", "xy"]

    for word in words {
        var vowelCount = 0
        var vowelRule = false

        for vowel in vowels {
            vowelCount += word.components(separatedBy: "\(vowel)").count - 1
            vowelRule = vowelCount >= 3
            if vowelRule {
                break
            }
        }

        let doublesRule = zip(word, word.dropFirst()).filter{$0 == $1}.count != 0

        var illegalRule = false
        for string in illegal {
            illegalRule = word.contains(string)
            if illegalRule {
                break
            }
        }

        if (doublesRule && vowelRule && !illegalRule) {
            niceStrings += 1

        }
    }
    
    print(niceStrings)
}
