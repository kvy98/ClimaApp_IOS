//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
protocol WeatherViewDelegate{
    func updateUI(weather:WeatherModel)
}
class WeatherViewController: UIViewController{
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    let locationManager=CLLocationManager()
    let weatherManager=WeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        searchTextField.delegate=self
    }
    
    func fetchData(searchInput:String)  {
        if !searchInput.isEmpty{
            weatherManager.performRequestByCityname(cityName: searchInput, delegate: self)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let inputSearch=textField.text{
            textField.endEditing(true)
            fetchData(searchInput: inputSearch.lowercased())
        }
        return true
    }
    @IBAction func searchButton(_ sender: UIButton) {
        if let inputSearch=searchTextField.text{
            searchTextField.endEditing(true)
            fetchData(searchInput: inputSearch)
        }    }
    
    @IBAction func locationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}
extension WeatherViewController:UITextFieldDelegate{
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.text=""
        return true
    }
}
extension WeatherViewController:WeatherViewDelegate{
    func updateUI(weather:WeatherModel) {
        DispatchQueue.main.async {
            self.cityLabel.text=weather.cityName
            self.conditionImageView.image=UIImage.init(systemName: weather.getWeather())
            self.temperatureLabel.text=weather.tempString
        }
    }
}
extension WeatherViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location=locations.last?.coordinate
        self.weatherManager.performRequestByCordinator(lon: location?.longitude, lat: location?.latitude, delegate: self)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}
