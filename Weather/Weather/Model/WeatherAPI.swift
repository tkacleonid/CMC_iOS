//
//  WeatherAPI.swift
//  Weather
//
//  Created by Leonid Tkachenko on 11/7/17.
//  Copyright © 2017 Leonid Tkachenko. All rights reserved.
//

import Foundation

class WeatherAPI
{
    static let API_ADDRESS = "https://api.apixu.com/v1/forecast.json?key=63819141cbed4a7282b95424173110"
    
    static func getApiAdress(city: String) -> String{
        return "\(API_ADDRESS)&q=\(city)&days=7"
    }
    
    static func loadCurrentWeather(weatherP: DayWeather, calback: @escaping () -> Void)
    {
    
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let urlString = WeatherAPI.getApiAdress(city: weatherP.cityEng)
        let url = URL(string: urlString)!
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request,
                                    completionHandler: { data, response, error in
                                        
                                        guard let data = data, error == nil else {
                                            print("error=\(String(describing: error))")
                                            return
                                        }
                                        let json = try? JSONSerialization.jsonObject(with: data, options: [])
                                        
                                        if let dictionary = json as? [String: Any] {
                                            if let weather = dictionary["current"] as? [String: Any] {
                                                if let temp_c = weather["temp_c"] as? Double {
                                                    weatherP.temperature = Int(temp_c)
                                                }
                                                
                                                if let humidity = weather["humidity"] as? Double {
                                                    weatherP.humidity = Int(humidity)
                                                }
                                                
                                                if let wind_kph = weather["wind_kph"] as? Double {
                                                    weatherP.wind = Int(wind_kph*(1000/3600))
                                                }
                                                
                                                if let pressure = weather["pressure_in"] as? Double {
                                                    weatherP.pressure = Int(pressure*25.4)
                                                }
                                                
                                                if let condition = weather["condition"] as? [String:Any] {
                                                    if let icon = condition["icon"] as? String {
                                                        weatherP.image = "https:"+icon
                                                    }
                                                }
                                            }
                                            
                                        }
                                        
                                        let url = URL(string: weatherP.image)
                                        weatherP.imageData = try? Data(contentsOf: url!)
                                        calback()

        })
        
        task.resume()
    }
    
 
    static func loadWeather(tag: Int, weatherP: DayWeather, calback: @escaping () -> Void) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let url = URL(string: WeatherAPI.getApiAdress(city: weatherP.cityEng))!
        
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request,
                                    completionHandler: { data, response, error in
                                        
                                        guard let data = data, error == nil else {
                                            print("error=\(String(describing: error))")
                                            return
                                        }
                                        
                                        let json = try? JSONSerialization.jsonObject(with: data, options: [])
                                        
                                        if let dictionary = json as? [String: Any] {
                                            
                                            if let forecast = dictionary["forecast"] as? [String: Any] {
                                                if let forecastday = forecast["forecastday"] as? [[String:Any]] {
                                                    if let day = forecastday[tag] as? [String:Any] {
                                                        if let weather = day["hour"] as? [[String:Any]] {
                                                            if let temp_c = weather[12]["temp_c"] as? Double {
                                                                weatherP.temperature = Int(temp_c)
                                                            }
                                                            
                                                            if let humidity = weather[12]["humidity"] as? Double {
                                                                weatherP.humidity = Int(humidity)
                                                            }
                                                            
                                                            if let wind_kph = weather[12]["wind_kph"] as? Double {
                                                                weatherP.wind = Int(wind_kph*(1000/3600))
                                                            }
                                                            
                                                            if let pressure = weather[12]["pressure_in"] as? Double {
                                                                weatherP.pressure = Int(pressure*25.4)
                                                            }
                                                            
                                                            if let condition = weather[12]["condition"] as? [String:Any] {
                                                                if let icon = condition["icon"] as? String {
                                                                    weatherP.image = "https:"+icon
                                                                }
                                                            }
                                                            
                                                        }
                                                    }
                                                }
                                                
                                            }
                                            
                                        }
                                        let url = URL(string: weatherP.image)
                                        weatherP.imageData = try? Data(contentsOf: url!)
                                        calback()
                                        
                                        
        })
        
        task.resume()
        
    }
    
    
    static func loadHourForecast(location: String, forecastP: Forecast, calback: @escaping () -> Void) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let url = URL(string: WeatherAPI.getApiAdress(city: location))!
        
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request,
                                    completionHandler: { data, response, error in
                                        
                                        guard let data = data, error == nil else {
                                            print("error=\(String(describing: error))")
                                            return
                                        }
                                        
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                                        
                                        let json = try? JSONSerialization.jsonObject(with: data, options: [])
                                        
                                        if let dictionary = json as? [String: Any] {
                                            
                                            if let forecast = dictionary["forecast"] as? [String: Any] {
                                                if let forecastday = forecast["forecastday"] as? [[String:Any]] {
                                                    
                                                    for day in 0...6 {
                                                        let day = forecastday[day]
                                                        if let weather = day["hour"] as? [[String:Any]] {
                                                                
                                                            for hour in 0...23 {
                                                                let weatherP = DayWeather()
                                                                
                                                                if let temp_c = weather[hour]["temp_c"] as? Double {
                                                                    weatherP.temperature = Int(temp_c)
                                                                }
                                                                
                                                                if let humidity = weather[hour]["humidity"] as? Double {
                                                                    weatherP.humidity = Int(humidity)
                                                                }
                                                                
                                                                if let wind_kph = weather[hour]["wind_kph"] as? Double {
                                                                    weatherP.wind = Int(wind_kph*(1000/3600))
                                                                }
                                                                
                                                                if let pressure = weather[hour]["pressure_in"] as? Double {
                                                                    weatherP.pressure = Int(pressure*25.4)
                                                                }
                                                                
                                                                if let date = weather[hour]["time"] as? String {
                                                                    weatherP.date = dateFormatter.date(from: date)!
                                                                }
                                                                
                                                                
                                                                if let condition = weather[hour]["condition"] as? [String:Any] {
                                                                    if let icon = condition["icon"] as? String {
                                                                        weatherP.image = "https:"+icon
                                                                    }
                                                                }

                                                                forecastP.items.append(weatherP)
                                                                
                                                            }
                                                        }
                                                    }
                                                }
                                                
                                            }
                                            
                                        }
                                        calback()
                                        
                                        
        })
        
        task.resume()
        
    }
    
    static func iconDataWithName(path: String, completionHandler: @escaping ((Data?) -> Void)) {
        let urlString = path
        guard let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let data = try? Data(contentsOf: url)
            completionHandler(data)
        }
    } 
}
