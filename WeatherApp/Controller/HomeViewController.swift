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
    private let backgroundImageView = UIImageView()
    private let searchStackView = SearchStackView()
    private let mainStackView = UIStackView()
    private let statusImageView = UIImageView()
    private let tempLabel = UILabel()
    private let cityLabel = UILabel()
    private let locationManager = CLLocationManager()
    // MARK: - Lifecycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
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
    }
    private func layout(){
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        /*
         view.addSubview(locationButton)
         view.addSubview(searchButton)
         view.addSubview(searchTextField)
         */
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
            

            
            /*locationButton işlemleri
            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),// gücenli alan çentik altı
            locationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
             
             //searchButton işlemleri
             searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
             searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),//sağ taraf işelmeri için - kullanmaka gerekiyor
             // view.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 12) böyle yaparsak - ye gerek yok
             
             //searchTextField işlemleri
             searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
             searchTextField.leadingAnchor.constraint(equalTo: locationButton.trailingAnchor, constant: 10),
             //searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),
             searchButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 10)
            */
          
            
            
            

            
        ])
    }
    private func attributedText(with text: String) -> NSMutableAttributedString{
        let attributedText = NSMutableAttributedString(string: text, attributes: [.foregroundColor : UIColor.label, .font : UIFont.boldSystemFont(ofSize: 80)])
        attributedText.append(NSAttributedString(string: "°C",attributes: [.font : UIFont.systemFont(ofSize: 65)]))
        return attributedText
    }
    private func configureLocation(){
        locationManager.requestWhenInUseAuthorization()
    }
}

