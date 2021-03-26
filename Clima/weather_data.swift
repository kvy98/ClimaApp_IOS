//
//  weather_data.swift
//  Clima
//
//  Created by Đinh Khánh Vỹ on 24/03/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

struct WeatherData:Codable {
    let cod:Int
    let name:String
    let weather:[Weather]
    let main:Main
}
struct Weather:Codable {
    let id:Int
    let description:String
}
struct Main:Codable {
    let temp:Float
}
