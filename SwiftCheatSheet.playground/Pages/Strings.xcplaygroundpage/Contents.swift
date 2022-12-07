// Get a substring or char from an index range
let numberString = "1-45 809 abc"

let startIndex = String.Index(utf16Offset: 2,
                              in: numberString)

let endIndex = String.Index(utf16Offset: 3,
                            in: numberString)

let numberSubString = numberString[startIndex...endIndex] // index range
let numberChar = numberString[startIndex] // single index

type(of: numberSubString) // substring
type(of: numberChar) // character

Int(numberSubString)
numberChar.wholeNumberValue

// Convert integer ranges to string index ranges
extension StringProtocol {
    subscript(_ range: Range<Int>) -> SubSequence {
        let lowerBound = Index(utf16Offset: range.lowerBound, in: self)
        let upperBound = Index(utf16Offset: range.upperBound, in: self)
        return self[lowerBound..<upperBound]
    }
    
    subscript(_ index: Int) -> SubSequence.Element {
        let index = Index(utf16Offset: index, in: self)
        return self[index]
    }
}

numberString[2] // substring
numberString[2..<4] // substring

// Test for membership of a substring
numberString.contains("45")

// Prefix + Suffix
numberString.prefix(4)
numberString.hasPrefix("1-45")
numberString.suffix(3)
numberString.hasSuffix("abc")

// Last + First
numberString.last
numberString.first

// Get the index range of a substring or char
numberString.firstIndex(of: "4") // only for chars

if let range = numberString.firstRange(of: "45") { // for substrings
    range.lowerBound.utf16Offset(in: numberString)
    range.upperBound.utf16Offset(in: numberString)
    // ranges are [x,y) ...upperBound not included

    // or
    // numberString.distance(from: numberString.startIndex, to: range.lowerBound)
    // numberString.distance(from: numberString.startIndex, to: range.upperBound)
}

// Casing
numberString.lowercased()
numberString.uppercased()

// Reverse
numberString.reversed() // for iterating
String(numberString.reversed()) // the actual reversed string

// Regex, the new way
// Regex literal
let regex = /a(.*)b/
if let result = "cbaxb".firstMatch(of: regex) {
    result.0 // "axb"
    result.1 // x
}

// No need to group unless you need extracting a substring from a regex match

let integerRegex = /\d+/
if let match = numberString.firstMatch(of: integerRegex) {
    match.0 // 1
}

let matches = numberString.matches(of: integerRegex)
matches.count // 3
let output = matches.map { $0.output }
output
type(of: output[0])
// A match always starts with the full match, and then any captured group follows
// This is checked by the compiler when using regex literals!
// If you can't use literals, use #"regex"#


// Regex, the old, safe way
import Foundation

let regex2 = try NSRegularExpression(pattern: #"\d+"#)
let range2 = NSRange(numberString.startIndex..<numberString.endIndex,
                    in: numberString)
regex2.matches(in: numberString, range: range2).map { match in
    let nsrange = match.range
    let range = Range.init(nsrange, in: numberString)!
    return numberString[range]
}

// Another example
let coordStr = "(4,5) - (6,7) - (8,9)"
let regex3 = try NSRegularExpression(pattern: #"(\d+),(\d+)"#)
let range3 = NSRange(coordStr.startIndex..<coordStr.endIndex,
                    in: coordStr)

// Full matches
regex3.matches(in: coordStr, range: range3).map {
    let nsrange = $0.range
    let range = Range.init(nsrange, in: coordStr)!
    return coordStr[range]
}

// Capture groups
regex3.matches(in: coordStr, range: range3).map {

    let nsrangeA = $0.range(at: 1)
    let rangeA = Range.init(nsrangeA, in: coordStr)!

    let nsrangeB = $0.range(at: 2)
    let rangeB = Range.init(nsrangeB, in: coordStr)!

    return (coordStr[rangeA], coordStr[rangeB])
}
