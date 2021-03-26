//
//  weather_manager.swift
//  Clima
//
//  Created by Đinh Khánh Vỹ on 24/03/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
struct WeatherManager {
    let apikey="fbbcc431bd1f209d9a022cf7459e2aae"
    let endpoint="https:api.openweathermap.org/data/2.5/weather"
    func performRequestByCityname(cityName:String,delegate:WeatherViewDelegate) {
        let url=URL(string: "\(endpoint)?q=\(cityName)&appid=\(apikey)&units=metric")
        performRequest(delegate: delegate, url: url)
    }
    func performRequestByCordinator(lon:Double?,lat:Double?,delegate:WeatherViewDelegate)  {
        let url=URL(string: "\(endpoint)?lat=\(lat!)&lon=\(lon!)&appid=\(apikey)&units=metric")
        performRequest(delegate: delegate, url: url)
    }
    func performRequest(delegate:WeatherViewDelegate,url:URL?){
        if url==nil{
            return
        }
        let urlSession=URLSession(configuration:.default)
        let task=urlSession.dataTask(with: url!){
            data,urlResponse,error in
            if let urlResponse=urlResponse as? HTTPURLResponse{
                if(urlResponse.statusCode==200){
                    let weatherData=parseJson(data: data)
                    if let weatherData=weatherData{
                        let weater=WeatherModel(temp: weatherData.main.temp, cityName: weatherData.name, idWeather: weatherData.weather[0].id)
                        delegate.updateUI(weather: weater)
                    }
                }
            }
        }
        task.resume()
    }
    func parseJson(data:Data?) -> WeatherData? {
        if(data==nil){
            return nil
        }
        let jsonDecode=JSONDecoder()
        do{
            let weather=try jsonDecode.decode(WeatherData.self, from: data!)
            return weather
        }
        catch{
            print(error)
            return nil
        }
    }
}
