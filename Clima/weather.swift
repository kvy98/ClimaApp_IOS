//
//  weather.swift
//  Clima
//
//  Created by Đinh Khánh Vỹ on 24/03/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

struct WeatherModel {
    var temp:Float
    var cityName:String
    var idCondition:Int
    var tempString:String{
        String(format: "%.1f", temp)
    }
    func getWeather() -> String {
        switch idCondition {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    init(temp:Float,cityName:String,idWeather:Int) {
        self.cityName=cityName
        self.temp=temp
        self.idCondition=idWeather
    }
}
