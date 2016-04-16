//
//  Location.swift
//  OpenWeather
//
//  Created by LUCIANO WEHRLI on 15/4/16.
//  Copyright © 2016 LA NACION. All rights reserved.
//

import Foundation

struct prediction {
    var main: String!
    var predict_description: String!
}

class Weather{
    var temperature : String?
    var pressure : String?
    var humidity : String?
    var temp_max : String?
    var temp_min : String?
    var clouds_porcentage : String?
    var sea_level : String?
    var predictions : Array<prediction>?
    
    init(content: Dictionary<String, AnyObject>){        
        guard let main = content["main"] as? Dictionary<String, AnyObject> else { return }
        guard let weather = content["weather"] as? Array<Dictionary<String, AnyObject>> else { return }
        guard let clouds = content["clouds"] as? Dictionary<String, AnyObject> else { return }
        
        if let temp = main["temp"]{
            self.temperature = "\(temp)"
        }else{
            self.temperature = ""
        }

        if let pres = main["pressure"]{
            self.pressure = "\(pres)"
        }else{
            self.pressure = ""
        }
        
        if let hum = main["humidity"]{
            self.humidity = "\(hum)"
        }else{
            self.humidity = ""
        }
        
        if let temp_min = main["temp_min"]{
            self.temp_min = "\(temp_min)"
        }else{
            self.temp_min = ""
        }

        if let temp_max = main["temp_max"]{
            self.temp_max = "\(temp_max)"
        }else{
            self.temp_max = ""
        }
        
        if let sea = main["sea_level"]{
            self.sea_level = "\(sea)"
        }else{
            self.sea_level = ""
        }
        
        if let cloud_level = clouds["all"]{
            self.clouds_porcentage = "\(cloud_level)"
        }else{
            self.clouds_porcentage = ""
        }
        
        self.predictions = [prediction]()
        if !weather.isEmpty{
            for var pre in weather{
                let main = "\(pre["main"] as! String)"
                let desc = "\(pre["description"] as! String)"
                let pred = prediction(main: main, predict_description: desc)
                self.predictions?.append(pred)
            }
        }
    }

}