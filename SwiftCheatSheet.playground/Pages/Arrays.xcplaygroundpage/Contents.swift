//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

let data = [
    "a",
    "b",
    //"c",
    "d",
    "e",
    "f",
    "g"
]


extension Array where Element: Comparable {
    func binarySearch(for element: Element) -> Bool {
        if count == 0 {
            return false
        }

        let middleIdx = count / 2

        if element == self[middleIdx] {
            return true
        } else if element < self[middleIdx] {
            return Array(self[..<middleIdx]).binarySearch(for: element)
        } else {
            return Array(self[(middleIdx + 1)...]).binarySearch(for: element)
        }
    }
}

data[data.count...]
data[data.count..<data.count]
let sortedData = data.sorted()
sortedData.binarySearch(for: "c")
sortedData.binarySearch(for: "i")
sortedData.binarySearch(for: "b")
sortedData.binarySearch(for: "d")
sortedData.binarySearch(for: "e")
sortedData.binarySearch(for: "f")
sortedData.binarySearch(for: "g")

//: [Next](@next)
