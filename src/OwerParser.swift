import Foundation
import Glibc

class OwerParser{
    let converte = ["zero":0,
                    "one":1,
                    "two":2,
                    "three":3,
                    "four":4,
                    "five":5,
                    "six":6,
                    "seven":7,
                    "eight":8,
                    "nine":9,
                    "ten":10]
    var flag:Bool
    var quantity:Int
    var dQuantity:Double
    var object:String
    var ower:String
    var receiver:String
    var receivable:String
    var owePos:Int
    var atPos:Int
    var iou:IOU

    init(){
        iou = IOU()
        quantity = 0
        dQuantity = -1.0
        object = ""
        ower = ""
        receiver = ""
        receivable = ""
        owePos = 0
        atPos = 0
        flag = false
    }

    func parse(x: String){
        quantity = 0
        dQuantity = -1.0
        flag = false
        var arr = x.components(separatedBy:" ")
        if x.contains(" @"){
            if x.contains(" owe ") || x.contains(" ought "){
                owePos = (x.contains(" owe ")) ? arr.index(of:"owe")! : arr.index(of:"ought")!
                let pre = arr[owePos-1].lowercased()
                let post = arr[owePos+1].lowercased()
                if !["you","u","i"].contains(pre){
                    return//print("NOT VALID")//replace whit return
                }else if !["you","u","me"].contains(post){
                    return//print("NOT VALID")//replace with return
                }
                if pre == "you" || pre == "u"{
                    receiver = "me"
                    ower = "you"
                }else /*post == "you" || post == "u"*/{
                    receiver = "you"
                    ower = "i"
                }
            }
            else if x.contains(" o "){
                var arr = x.components(separatedBy:" ")
                owePos = arr.index(of:"o")!
                let pre = arr[owePos-1].lowercased()
                let post = arr[owePos+1].lowercased()
                if pre == "you" || pre == "u"{
                    receiver = "me"
                    ower = "you"
                }
                else if post == "you" || post == "u"{
                    receiver = "you"
                    ower = "i"
                }
            }else{
                return//print("NOT VALID")//replace
            }
        }else{
            return//print("NOT VALID")//replace
        }
        if ower != "" {
            for i in 0..<arr.count{
                var temp = arr[i]
                if temp.starts(with:"@"){
                    atPos = i
                    while [",",";",":",".","?","!"].contains(temp.last!){
                        temp = String(temp.dropLast())
                    }
                    receivable = String(temp.characters.suffix(temp.count-1))
                    if temp.last != "s"{
                        quantity = 1
                        flag = true
                    }
                    continue
                }
            }
        }
        if !flag{
            for i in owePos...atPos{
                let word = arr[i].lowercased()
                if word.contains("couple") || word.contains("pair"){
                    quantity = 2
                    flag = true
                    continue
                }else if word == "an"{
                    quantity = 1
                    flag = true
                    continue
                }else if word.contains("."){
                    let number = Double(arr[atPos-1] as String)
                    if number != nil {
                        dQuantity = number!
                        flag = true
                    }
                    continue
                }else if Array(converte.keys).contains(word) {
                    quantity = converte[word]!
                    flag = true
                    continue
                }else{
                    let num = Int(word)
                    if num != nil {
                        quantity = num!
                        flag = true
                    }
                    continue
                }
            }
        }
        let stringQuantity = (dQuantity < Double(quantity)) ? String(quantity) : String(dQuantity)
        //print("\(ower) owe \(receiver) \(stringQuantity) \(receivable)")
        if flag{
            iou.add(x:(ower,receiver,receivable,stringQuantity))
        }
    }

    func getAllIous(){
        for i in iou.getAll(){
            print("\(firstUppercased(s:i.0)) owe \(i.1) \(i.3) \(i.2)")
        }
    }
}

func firstUppercased(s:String) -> String {
    return s == "i" ? "I" : "You"
}

class IOU{
    var ious:Array<(String,String,String,String)>
    init(){
        ious = []
    }

    func add(x:(String,String,String,String)){
        let count = ious.count
        for i in 0..<count{
            if ious[i].2 == x.2{
                merge(x:x,i:i)
                return
            }else if(ious[i].2 == x.2+"s"){
                merge(x:x,i:i)
                return
            }else if(ious[i].2+"s"==x.2){
                merge(x:x,i:i)
                return
            }
        }
        ious.append(x)
    }

    func merge(x:(String,String,String,String),i:Int){
        var mine = 0.0
        var yours = 0.0
        if(ious[i].0 == "you"){
            mine += Double(ious[i].3)!
        }else{
            yours += Double(ious[i].3)!
        }
        if(x.0 == "you"){
            mine += Double(x.3)!
        }else{
            yours += Double(x.3)!
        }
        let delta = mine - yours
        let receivables = ious[i].2
        ious.remove(at:i)
        print(delta)
        if delta>0 {
            ious.append(("you","me",receivables,String(delta)))
        }else if delta<0{
            ious.append(("i","you",receivables,String(delta)))
        }
    }

    func getter(ower:String) -> Array<(String,String,String,String)>{
        var temp = Array<(String,String,String,String)>()
        for iou in ious{
            if ious[0].0 == ower{
                temp.append(iou)
            }
        }
        return temp
    }

    func getMyOwes()-> Array<(String,String,String,String)>{
        return getter(ower:"i")
    }

    func getYourOwes()-> Array<(String,String,String,String)>{
        return getter(ower:"you")
    }

    func getAll() ->Array<(String,String,String,String)>{
        return ious
    }
}


var parser = OwerParser()
parser.parse(x:"I owe you three @pounds")
parser.getAllIous()
parser.parse(x:"You owe me 4 @pounds")
parser.getAllIous()
