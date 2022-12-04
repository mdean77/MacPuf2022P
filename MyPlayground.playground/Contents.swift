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


