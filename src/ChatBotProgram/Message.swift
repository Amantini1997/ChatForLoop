//
//  Message.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-06-04.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import UIKit

enum MessageType {
    case user
    case botText
    case loanMessage
}

class Message {
    
    var text: String = ""
    var date: Date
    var type: MessageType
    
    init(date: Date, type: MessageType) {
        self.date = date
        self.type = type
    }
    
    convenience init(text: String, date: Date, type: MessageType) {
        self.init(date: date, type: type)
        self.text = text
    }
    

    
    // MARK : create a text response for weather condition intnet
    func getCondtionAnswer(_ weather: Weather, _ intent: Intent) -> String {
       
        var text = ""
        let condition = intent.weather!.condition!
        var dates = [Date()];
        var booleanAnswer = "No, is not forecast " + condition
        
        if(intent.dates != nil && intent.dates!.count > 0) {
            dates = intent.dates!
        }
        
        
        
            //check condtion in the current day
            let todayCondition = weather.condition.text
        
            if todayCondition.lowercased().range(of: condition) != nil {
                booleanAnswer = "Yes, "
            }
            print(weather.forecast.first)
            text = booleanAnswer + "Today is forecast " + todayCondition
            
    
        return  text
    }
    
    //MARK : return user or bot image
    func getImage() -> String {
        switch self.type {
        case .user:
            return "user.png"
        default:
            return "bot.pdf"
        }
    }

}
