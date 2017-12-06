//
//  Forecast.swift
//  Weather
//
//  Created by Leonid Tkachenko on 01/11/2017.
//  Copyright © 2017 Leonid Tkachenko. All rights reserved.
//

import Foundation

class Forecast {
    var items = [DayWeather]()
    
    static func defaultForecast() -> Forecast {
        let forecast = Forecast()
        
        let today = DayWeather()
        today.temperature = 12
        forecast.items.append(today)
        
        let tomorrow = DayWeather()
        tomorrow.temperature = 1
        forecast.items.append(tomorrow)
        
        return forecast
    }
}

