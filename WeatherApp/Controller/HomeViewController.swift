//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yakup Suda on 22.03.2023.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {

    // MARK: - Properties
    var viewModel: WeatherViewModel?{
        didSet{
            configure()
        }
    }
    private let backgroundImageView = UIImageView()
    private let searchStackView = SearchStackView()
    private let mainStackView = UIStackView()
    private let statusImageView = UIImageView()
    private let tempLabel = UILabel()
    private let cityLabel = UILabel()
    private let locationManager = CLLocationManager()
    private let service = WeatherService()
    private let admin = UILabel()
    // MARK: - Lifecycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        configureLocation()
    }
}

// MARK: - Helpers
extension HomeViewController {
    private func style(){
        // backgroundImageView style
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false // otomatik düzenleme kaldırıldı
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image =  UIImage(named: "Background")
        
        //searchStackView style
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        searchStackView.spacing = 10 // her eleman arasındaki boşluk
        searchStackView.axis = .horizontal // yatay yada dikey düzlem seçimi
        searchStackView.delegate = self
        //mainStackView style
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.spacing = 20
        mainStackView.axis = .vertical // dikey işlem
        mainStackView.alignment = .trailing  // sağa doğru yasla
        //statusImageView style
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        statusImageView.image = UIImage(systemName: "sun.max")
        statusImageView.tintColor = .label
        //tempLabel style
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.font = UIFont.systemFont(ofSize: 80)
        tempLabel.attributedText = attributedText(with: "15")
        //cityLabel style
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        cityLabel.text = "Kütahya"
        //admin style
        admin.translatesAutoresizingMaskIntoConstraints = false
        admin.textColor = UIColor.darkText
        admin.font = UIFont.boldSystemFont(ofSize: 25)
        admin.text = "Yakup Suda Tarafından Yapıldı"
        
    }
    private func layout(){
        view.addSubview(backgroundImageView)
        view.addSubview(admin)
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(searchStackView)
        mainStackView.addArrangedSubview(statusImageView)
        mainStackView.addArrangedSubview(tempLabel)
        mainStackView.addArrangedSubview(cityLabel)
        NSLayoutConstraint.activate([
            //backgroundImageView işlemleri
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor), // üst
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),//sol taraf
            view.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor), // sağ taraf
            view.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor), // alt
            
            
            //mainStackView işlemleri
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),// gücenli alan çentik altı
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 8),
            
            searchStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),// diğer stack ile aynı boyuta getirdik
            
            //statusImageView işlemleri
            statusImageView.heightAnchor.constraint(equalToConstant: 100),
            statusImageView.widthAnchor.constraint(equalToConstant: 100),
            
            //admin işlemleri
            admin.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            admin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            admin.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -10)
        ])
    }
    private func attributedText(with text: String) -> NSMutableAttributedString{
        let attributedText = NSMutableAttributedString(string: text, attributes: [.foregroundColor : UIColor.label, .font : UIFont.boldSystemFont(ofSize: 80)])
        attributedText.append(NSAttributedString(string: "°C",attributes: [.font : UIFont.systemFont(ofSize: 65)]))
        return attributedText
    }
    private func configureLocation(){
        locationManager.requestWhenInUseAuthorization() // izin işlemi
        locationManager.startUpdatingLocation() // lokasyonu al
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // doğrulul payı
        locationManager.delegate = self
        
    }
    
    private func configure(){
        guard let viewModel = self.viewModel else { return }
        self.cityLabel.text = viewModel.cityName
        self.tempLabel.attributedText = attributedText(with: viewModel.tempString)
        self.statusImageView.image = UIImage(systemName: viewModel.statusName)
    }
    
    private func showErrorAlert(forErrorMessega message: String, forError error: String){
        let alert = UIAlertController(title: error, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Error", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    private func parseError(error: ServiceError){
        switch error{
        case .serverError:
            showErrorAlert(forErrorMessega: error.rawValue, forError: "Error")
        case .decodingError:
            showErrorAlert(forErrorMessega: error.rawValue, forError:  "Error")
        }
    }
}
//MARK: - CLLocationManagerDelegete
extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        locationManager.stopUpdatingLocation()
        self.service.fetchWeatherLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { result in
            switch result{
            case .success(let result):
                self.viewModel = WeatherViewModel(weatherModel: result)
            case .failure(let error):
                self.parseError(error: error)
            }
        }
    }
}
//MARK: -SearchStackViewDelegate
extension HomeViewController: SearchStackViewDelegate{
    func updatingLocation(_ searchStackView: SearchStackView) {
        self.locationManager.startUpdatingLocation()
    }
    func didFailWithError(_ searchStackView: SearchStackView, error: ServiceError) {
        parseError(error: error)
    }
    
    func didFetchWeather(_ searchStackView: SearchStackView, weatherModel: WeatherModel) {
        self.viewModel = WeatherViewModel(weatherModel: weatherModel)
    }
    
    
}
