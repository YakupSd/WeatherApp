//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Yakup Suda on 22.03.2023.
//

import Foundation

struct WeatherModel: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp:  Double
}
struct Weather: Codable {
    let main: String
    let description: String
    let id: Int
    
}
