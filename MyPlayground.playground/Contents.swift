import SwiftUI

var FIO2: Float = 20.93
var FIC2: Float = 0.03
var a:Float = 1
var b:Float = 2

var paramsToCollect:[String]=[]

paramsToCollect.append("FIC2")
paramsToCollect.append("a")
FIC2 = 80
var string = "\(paramsToCollect)"


var params:[String:Float]=[:]
params["FiO2"] = FIO2
params["FiCO2"] = FIC2

string = "\(params)"
FIC2 = 0.09
string = "\(params)"

paramsToCollect[0]

enum OutputFormats:String, CaseIterable, Equatable {
    case GraphsOnly = "Graphs Only"
    case GraphsAndTables = "Graphs and Tables"
    case SelectedVariables = "Selected Parameters"
}

var outputFormat:OutputFormats = .GraphsAndTables
outputFormat.rawValue

OutputFormats(rawValue: "Selected Parameters")

OutputFormats.allCases
for value in OutputFormats.allCases {
    value
}
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

var myContent = "This is a really long string \nthat has several lines in it\nincluding some end of line \ncharacters and I want to know \nhow many lines are in it."

myContent.countInstances(of: "\n")

Text(myContent)
myContent.append(myContent)

print(myContent)

myContent.countInstances(of: "\n")

var stringArray = myContent.split(separator: "\n")
print(stringArray)
for item in 1..<stringArray.count {
    print(stringArray[item])
}
