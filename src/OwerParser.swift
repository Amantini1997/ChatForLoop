import Foundation
import Glibc


var x:String = "hey, you owe Josh 2 @pints and 3 , you cheap fuckhead"
var quantity = 0
var dQuantity = -1.0
var object:String = ""
var ower = ""
var receiver = ""
var receivable = ""
var arr = x.components(separatedBy:" ")
var owePos = 0;
var atPos = 0;
if x.contains(" @"){
    if x.contains(" owe ") || x.contains(" ought "){
        owePos = (x.contains(" owe ")) ? arr.index(of:"owe")! : arr.index(of:"ought")!
        let pre = arr[owePos-1].lowercased()
        let post = arr[owePos+1].lowercased()
        if !["you","u","i"].contains(pre){
            print("NOT VALID")//replace whit return
        }else if !["you","u","me"].contains(post){
            print("NOT VALID")//replace with return
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
        print("NOT VALID")//replace
    }
}else{
    print("NOT VALID")//replace
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
