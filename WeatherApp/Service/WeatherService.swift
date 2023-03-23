//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Yakup Suda on 22.03.2023.
//

import Foundation
import CoreLocation
enum ServiceError: String ,Error {
    case serverError = "Check your network connection"
    case decodingError = "Decoding error"
}

struct WeatherService {
    let url = "https://api.openweathermap.org/data/2.5/weather?&APPID=eba2158ff055b82ff907af884c16d9e1&units=metric"

    //@escaping(Result<WeatherModel, Error>)->Void bunun sayesinden hata çıkmaz ise yada çıkarsa sonuç döndürüyoruz
    func fetchWeatherCityName(forCityName cityName: String, completion: @escaping(Result<WeatherModel, ServiceError>)->Void) {
        let url = URL(string: "\(url)&q=\(cityName)")!
        fetchWeather(url: url, completion: completion)
    }
    
    func fetchWeatherLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping(Result<WeatherModel, ServiceError>)->Void) {
        let url = URL(string: "\(url)&lat=\(latitude)&lon=\(longitude)")!
        fetchWeather(url: url, completion: completion)
    }
    
    
    private func fetchWeather(url: URL, completion: @escaping(Result<WeatherModel, ServiceError>)->Void){
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async { //veri gelene kadar bekle
                guard error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                guard let data = data else { return }
                guard let result = parseJSON(data: data) else {
                    completion(.failure(.decodingError))
                    return
                }
                completion(.success(result))//aşşağıdaki func dan gelen result değeier
            }
        }.resume()
    }
    
    private func parseJSON(data: Data)->WeatherModel?{
        do{
            let result = try JSONDecoder().decode(WeatherModel.self, from: data)
            return result
        } catch {
            return nil
        }
    }
}
