//
//  SearchStackView.swift
//  WeatherApp
//
//  Created by Yakup Suda on 22.03.2023.
//

import UIKit

class SearchStackView: UIStackView {
    //MARK: - Properties
    private let locationButton = UIButton(type: .system)
    private let searchButton = UIButton(type: .system)
    private let searchTextField = UITextField()
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
        //searchButton style
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .label
        searchButton.layer.cornerRadius = 40 / 2
        searchButton.contentVerticalAlignment = .fill
        searchButton.contentHorizontalAlignment = .fill
        //searchTextField style
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.placeholder = "Search Country"
        searchTextField.font = UIFont.preferredFont(forTextStyle: .title1)
        searchTextField.borderStyle = .roundedRect
        searchTextField.textAlignment = .center
        searchTextField.backgroundColor = .systemFill // arka plan rengi yapma
        
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
