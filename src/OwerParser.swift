import Foundation
import Glibc

class OwerParser{

    var quantity:Int
    var dQuantity:Double
    var object:String
    var ower:String
    var receiver:String
    var receivable:String
    var owePos:Int
    var atPos:Int

    init(){
        quantity = 0
        dQuantity = -1.0
        object = ""
        ower = ""
        receiver = ""
        receivable = ""
        owePos = 0;
        atPos = 0;
    }

    func parse(x: String) -> (String,String,String,String)?{
        var arr = x.components(separatedBy:" ")
        if x.contains(" @"){
            if x.contains(" owe ") || x.contains(" ought "){
                owePos = (x.contains(" owe ")) ? arr.index(of:"owe")! : arr.index(of:"ought")!
                let pre = arr[owePos-1].lowercased()
                let post = arr[owePos+1].lowercased()
                if !["you","u","i"].contains(pre){
                    return nil //print("NOT VALID")//replace whit return
                }else if !["you","u","me"].contains(post){
                    return nil //print("NOT VALID")//replace with return
                }
                if pre == "you" || pre == "u"{
                    receiver = "me"
                    ower = "You"
                }else /*post == "you" || post == "u"*/{
                    receiver = "you"
                    ower = "I"
                }
            }
            else if x.contains(" o "){
                var arr = x.components(separatedBy:" ")
                owePos = arr.index(of:"o")!
                let pre = arr[owePos-1].lowercased()
                let post = arr[owePos+1].lowercased()
                if pre == "you" || pre == "u"{
                    receiver = "me"
                    ower = "You"
                }
                else if post == "you" || post == "u"{
                    receiver = "you"
                    ower = "I"
                }
            }else{
                return nil //print("NOT VALID")//replace
            }
        }else{
            return nil //print("NOT VALID")//replace
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
                    }
                    continue
                }
            }
        }
        if dQuantity == -1.0{
            for i in owePos...atPos{
                let word = arr[i].lowercased()
                if word.contains("couple") || word.contains("pair"){
                    quantity = 2
                    continue
                }else if word == "an"{
                    quantity = 1
                    continue
                }else if word.contains("."){
                    dQuantity = Double(arr[atPos-1] as String) ?? -1.0
                    continue
                }/*else if(true){
                    let number = NumberFormatter.number(from: word)
                    quantity = number.integerValue ?? 0
                    continue
                }*/else{
                    let num = Int(word)
                    if num != nil {
                        quantity = num!
                    }
                    continue
                }
            }
        }
        let stringQuantity = (dQuantity < Double(quantity)) ? String(quantity) : String(dQuantity)
        print("\(ower) owe \(receiver) \(stringQuantity) \(receivable)")
        return(ower,receiver,receivable,stringQuantity)
    }
}

var parser = OwerParser()
parser.parse(x:"Hello mother fucker, do you remember that you owe me 2 fucking @pounds??")
