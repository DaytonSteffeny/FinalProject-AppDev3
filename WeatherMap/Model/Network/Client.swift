//
//  Client.swift
//  WeatherMap
//
//  Created by Dayton Steffeny on 10/18/19.
//  Copyright © 2019 Dayton Steffeny. All rights reserved.
//

import Foundation
import UIKit
import MapKit
protocol WeatherDelegate {
    func didGetWeather(weather : WeatherAPI)
    func didNotGetWeather(error : NSError)
    
}
class Client: NSObject {
    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var deleGate : WeatherDelegate
     init(deleGate : WeatherDelegate) {
        self.deleGate = deleGate
    }
   
    func getWeatherByCoor(lat : Double , lon : Double) {
        let weatherRequestURL = URL(string: "\(openWeatherURL)?lat=\(lat)&lon=\(lon)&appid=\(openWeatherIPkey)")!
        getWeather(weatherRequestURL: weatherRequestURL)
    }
    
    private let openWeatherURL = "https://api.openweathermap.org/data/2.5/weather"
    private let openWeatherIPkey = "bd5ac2232bd727451b6e7146911a3ea5"
    
    func getWeather(weatherRequestURL : URL){
   
        
            let task = URLSession.shared.dataTask(with: weatherRequestURL) { (data, response, error) in
        
                if let networkError = error {
                    self.deleGate.didNotGetWeather(error: networkError as NSError)
                } else {
                    if let usbleData = data {
                        print("usbleData size is : \(usbleData)")
                        do {
                            let weatherJSONData = try JSONSerialization.jsonObject(with: usbleData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: AnyObject]
                            let  weather = WeatherAPI(weatherData: weatherJSONData)
                           //print(weatherJSONData)
                            self.deleGate.didGetWeather(weather: weather)
                        }  catch let  jsonError as NSError{
                            // if error  accurs while convert data
                            self.deleGate.didNotGetWeather(error: jsonError)
                        
                        }
                    }
                }
                
            }
            task.resume()
        
        
    }
}
