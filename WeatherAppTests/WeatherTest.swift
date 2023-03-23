//
//  WeatherTest.swift
//  WeatherAppTests
//
//  Created by Yakup Suda on 23.03.2023.
//

import XCTest
@testable import WeatherApp
class WeatherTest: XCTestCase {
    
    func testParseWeather() throws{
        let json = """
         {
           "weather": [
              {
                 "id": 500,
                 "description": "light rain",
                     }
           ],
           "main": {
             "temp": 10.11,
           },
           "name": "Kayseri"
         }
        """
        let jsonData = json.data(using: .utf8)!
        do{
            let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: jsonData)
            XCTAssertEqual(10.11, weatherModel.main.temp)
        }
        catch{
            print("Error not match")
        }
        
    }
    
    func testNoCityName() throws{
        let json = """
             {
               "weather": [
                  {
                     "id": 500,
                     "description": "light rain",
                         }
               ],
               "main": {
                 "temp": 10.11,
               },
               "name": ""
             }
            """
        let jsonData = json.data(using: .utf8)!
        do {
            let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: jsonData)
            XCTAssertEqual("", weatherModel.name)
        }
        catch{
            
        }
        
    }
}
