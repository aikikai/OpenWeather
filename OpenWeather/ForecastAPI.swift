//
//  MapAPI.swift
//  OpenWeather
//
//  Created by LUCIANO WEHRLI on 15/4/16.
//  Copyright © 2016 LA NACION. All rights reserved.
//

import Foundation

class ForecastAPI {
    
    var completionLocal : ((jsonData: Weather?) -> Void)?
    
    func fetchData (latitude: String?, longitude: String?, completion: (jsonData: Weather?) -> Void) {
        completionLocal = completion
        let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        guard let lat = latitude else{ return }
        guard let lon = longitude else{ return }
        let url = "\(OPENWEATHER_BASE_URL)lat=\(lat)&lon=\(lon)&appid=\(OPENWEATHER_API_KEY)"
        guard let URL = NSURL(string: url) else { return }
        let task = defaultSession.dataTaskWithURL(URL, completionHandler: parseServerData)
        task.resume()
    }
    
    
    func parseServerData(data : NSData?, response: NSURLResponse?, error: NSError?){
        guard error == nil && data != nil else{
            print("Failed downloading data from json")
            return
        }
        do{
            if case let dataDict as Dictionary<String, AnyObject> = try NSJSONSerialization.JSONObjectWithData(data!, options: []) {
                let weatherLocal : Weather = Weather(content: dataDict)
                if weatherLocal.temperature != nil{
                    completionLocal?(jsonData: weatherLocal)
                }else{
                    completionLocal?(jsonData: nil)
                }
            }
        }catch _{
            print("Something went wrong with the weather initializer")
            completionLocal?(jsonData: nil)
        }
    }
    
}