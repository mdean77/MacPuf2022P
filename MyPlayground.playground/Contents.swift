import SwiftUI

extension String {
    /// stringToFind must be at least 1 character.
    func countInstances(of stringToFind: String) -> Int {
        assert(!stringToFind.isEmpty)
        var count = 0
        var searchRange: Range<String.Index>?
        while let foundRange = range(of: stringToFind, options: [], range: searchRange) {
            count += 1
            searchRange = Range(uncheckedBounds: (lower: foundRange.upperBound, upper: endIndex))
        }
        return count
    }
}
//                         1         2         3         4         5         6         7         8         9         9         1         2         3         4
//               012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456
var myContent = "This is a really long string \nthat has several lines in it \nincluding some end of line \ncharacters and I want to know \nhow many lines are in it."
let substring = "\n"
print("\(myContent.count) characters")

func findNthOccurrence(of substring:String, in string:String, n:Int) -> Int {
    let regex = try! NSRegularExpression(pattern: "\n", options: [.caseInsensitive, .ignoreMetacharacters])

    let range = NSRange(string.startIndex ..< string.endIndex, in: string)
    let matches = regex.matches(in:string, range:range)
    print(matches)
    if matches.count >= n {
        return(matches[n - 1].range.location)
    } else {
        return 0
    }
}


func indexOfNthOccurrence(of target: String, in string: String, n: Int? = nil) -> String.Index? {
    let startIndex = string.startIndex
    let endIndex = string.endIndex
    let options: NSRegularExpression.MatchingOptions = [.anchored]
    let range = NSRange(startIndex..<endIndex, in: string)

    let regex = try! NSRegularExpression(pattern: target, options: [])
    let matches = regex.matches(in: string, options: options, range: range)

    if let n = n, n <= matches.count {
        let result = matches[n - 1]
        return Range(result.range, in: string)?.lowerBound
    } else if matches.count > 0 {
        let result = matches[0]
        return Range(result.range, in: string)?.lowerBound
    } else {
        return nil
    }
}


myContent.countInstances(of: "\n")
let one = findNthOccurrence(of: "\n", in: myContent, n: 1)
let two = findNthOccurrence(of: "\n", in: myContent, n: 2)
let three = findNthOccurrence(of: "\n", in: myContent, n: 3)
let four = findNthOccurrence(of: "\n", in: myContent, n: 4)
let five = findNthOccurrence(of: "\n", in: myContent, n: 5)

myContent
myContent[myContent.startIndex..<myContent.endIndex]

myContent[myContent.index(myContent.startIndex, offsetBy: 0)..<myContent.index(myContent.startIndex, offsetBy: one)]
var startLocation = myContent.index(myContent.startIndex, offsetBy:0)
var endLocation = myContent.index(myContent.startIndex, offsetBy: one)
var substring1 = myContent[startLocation...myContent.index(before: endLocation)]
startLocation = myContent.index(myContent.startIndex, offsetBy:one)
endLocation = myContent.index(myContent.startIndex, offsetBy: two)
var substring2 = myContent[myContent.index(after:startLocation)...myContent.index(before: endLocation)]
startLocation = myContent.index(myContent.startIndex, offsetBy:two)
endLocation = myContent.index(myContent.startIndex, offsetBy: three)
var substring3 = myContent[myContent.index(after:startLocation)...myContent.index(before: endLocation)]
startLocation = myContent.index(myContent.startIndex, offsetBy:three)
endLocation = myContent.index(myContent.startIndex, offsetBy: four)
var substring4 = myContent[myContent.index(after:startLocation)...myContent.index(before: endLocation)]
startLocation = myContent.index(myContent.startIndex, offsetBy:four)
endLocation = myContent.endIndex
var substring5 = myContent[myContent.index(after:startLocation)...myContent.index(before: endLocation)]

substring1 + substring2 + substring3 + substring4 + substring5

 startLocation = myContent.index(myContent.startIndex, offsetBy:0)
 endLocation = myContent.index(myContent.startIndex, offsetBy: one)
 substring1 = myContent[startLocation...endLocation]
startLocation = myContent.index(myContent.startIndex, offsetBy:one)
endLocation = myContent.index(myContent.startIndex, offsetBy: two)
 substring2 = myContent[myContent.index(after:startLocation)...endLocation]
startLocation = myContent.index(myContent.startIndex, offsetBy:two)
endLocation = myContent.index(myContent.startIndex, offsetBy: three)
 substring3 = myContent[myContent.index(after:startLocation)...endLocation]
startLocation = myContent.index(myContent.startIndex, offsetBy:three)
endLocation = myContent.index(myContent.startIndex, offsetBy: four)
 substring4 = myContent[myContent.index(after:startLocation)...endLocation]
startLocation = myContent.index(myContent.startIndex, offsetBy:four)
endLocation = myContent.endIndex
 substring5 = myContent[myContent.index(after:startLocation)..<endLocation]

substring1 + substring2 + substring3 + substring4 + substring5

print(substring1 + substring2 + substring3 + substring4 + substring5)

myContent[myContent.index(myContent.startIndex, offsetBy: one)..<myContent.index(myContent.startIndex, offsetBy: two)]
myContent[myContent.index(myContent.startIndex, offsetBy: two)..<myContent.index(myContent.startIndex, offsetBy: three)]
myContent[myContent.index(myContent.startIndex, offsetBy: three)..<myContent.index(myContent.startIndex, offsetBy: four)]
//print(myContent[myContent.index(myContent.startIndex, offsetBy: four)..<myContent.index(myContent.startIndex, offsetBy: five)])
//CRASHES PLAYGROUND

let one1 = indexOfNthOccurrence(of: "\n", in: myContent, n: 1)
let two2 = indexOfNthOccurrence(of: "\n", in: myContent, n: 2)
let three3 = indexOfNthOccurrence(of: "\n", in: myContent, n: 3)
let four4 = indexOfNthOccurrence(of: "\n", in: myContent, n: 4)
let five5 = indexOfNthOccurrence(of: "\n", in: myContent, n: 5)


