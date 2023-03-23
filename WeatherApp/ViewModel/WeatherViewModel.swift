//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Yakup Suda on 22.03.2023.
//

import Foundation

struct WeatherViewModel {
    let id: Int
    let cityName: String
    let temp: Double
    
    init(weatherModel: WeatherModel) {
        self.id = weatherModel.weather[0].id
        self.cityName = weatherModel.name
        self.temp = weatherModel.main.temp
    }
    var tempString: String{
        return String(format: "%.0f", temp)// virgülden sonra hiçbirşey alma %.0f
    }
    
    var statusName: String {
        switch id {
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
}
