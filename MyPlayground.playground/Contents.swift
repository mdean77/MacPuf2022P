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
//                         1         2         3         4         5         6         7         8         9         9         1         2
//               0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456
var myContent = "This is a really long string \nthat has several lines in it\nincluding some end of line \ncharacters and I want to know \nhow many lines are in it."
let substring = "\n"

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




let one = findNthOccurrence(of: "\n", in: myContent, n: 1)
let two = findNthOccurrence(of: "\n", in: myContent, n: 2)
let three = findNthOccurrence(of: "\n", in: myContent, n: 3)
let four = findNthOccurrence(of: "\n", in: myContent, n: 4)
let five = findNthOccurrence(of: "\n", in: myContent, n: 5)
//let startIndex = myContent.index(myContent.startIndex, offsetBy: three)
//
//let endIndex = myContent.index(myContent.startIndex, offsetBy: five)
//myContent[startIndex...endIndex]
let arrayOfStrings = ["This is my content string and I will make it long.", "This is the next line of the array.",
                      "This is some more.","This is a new line indicator\n","Followed by three","\n\n\n", "and this is the final line."]
let newContent = arrayOfStrings[0..<2].joined()
let newerContent = arrayOfStrings[2..<4].joined()
let overallContent = arrayOfStrings[0..<arrayOfStrings.count].joined()

print(overallContent)


