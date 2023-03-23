//
//  SearchStackView.swift
//  WeatherApp
//
//  Created by Yakup Suda on 22.03.2023.
//

import UIKit
protocol SearchStackViewDelegate: AnyObject { // AnyObject yazma sebebi Weak bağlantı oluşturma
    func didFetchWeather(_ searchStackView: SearchStackView, weatherModel: WeatherModel)
    func didFailWithError(_ searchStackView: SearchStackView, error: ServiceError)
    func updatingLocation(_ searchStackView : SearchStackView)
}

class SearchStackView: UIStackView {
    //MARK: - Properties
    weak var delegate: SearchStackViewDelegate?
    private let locationButton = UIButton(type: .system)
    private let searchButton = UIButton(type: .system)
    private let searchTextField = UITextField()
    private let service = WeatherService()
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - Helpers
extension SearchStackView{
    private func  style(){
        // locationButton style
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        locationButton.tintColor = .label // siyah gözükmesi için
        locationButton.layer.cornerRadius = 40 / 2 // daire içine koysun diye (40 ı biz verdik ondan 2 ye bölüdk)
        locationButton.contentVerticalAlignment = .fill // büyültme işlemleri yatay ve dikey de
        locationButton.contentHorizontalAlignment = .fill // büyültme işlemleri yatay ve dikey de
        locationButton.addTarget(self, action: #selector(handleLocationButton), for: .touchUpInside)
        //searchButton style
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .label
        searchButton.layer.cornerRadius = 40 / 2
        searchButton.contentVerticalAlignment = .fill
        searchButton.contentHorizontalAlignment = .fill
        searchButton.addTarget(self, action: #selector(handleSearchButton), for: .touchUpInside)
        //searchTextField style
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.placeholder = "Search Country"
        searchTextField.font = UIFont.preferredFont(forTextStyle: .title1)
        searchTextField.borderStyle = .roundedRect
        searchTextField.textAlignment = .center
        searchTextField.backgroundColor = .systemFill // arka plan rengi yapma
        searchTextField.delegate = self
        
    }
    private func  layout(){
        addArrangedSubview(locationButton)
        addArrangedSubview(searchTextField)
        addArrangedSubview(searchButton)
        
        NSLayoutConstraint.activate([
            //locationButton işlenmleri
            locationButton.heightAnchor.constraint(equalToConstant: 40),
            locationButton.widthAnchor.constraint(equalToConstant: 40),
            
            //searchButton işlemleri
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
}

//MARK: - Selector

extension SearchStackView{
    @objc private func handleSearchButton(_ sender: UIButton){
        self.searchTextField.endEditing(true)
    }
    @objc private func handleLocationButton(_ sender: UIButton){
        self.delegate?.updatingLocation(self)
    }
}

//MARK: - UITextFieldDelegate
extension SearchStackView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //düzenleme bittikten sonra geç e basınca
        print("return")
        return self.searchTextField.endEditing(true)
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool { // düzenleme bitmeden önce
        if searchTextField.text != ""{
            return true
        }else {
            searchTextField.placeholder = "Search City"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {// bitirme işlemi
        guard let cityName = searchTextField.text else { return  }
        service.fetchWeatherCityName(forCityName: cityName) { result in
            switch result{
            case .success(let result):
                self.delegate?.didFetchWeather(self, weatherModel: result)
            case .failure(let error):
                self.delegate?.didFailWithError(self, error: error)
            }
        }
        self.searchTextField.text = ""
    }
}
