//
//  ViewController.swift
//  24-114-WeatherClient-Test
//
//  Created by Md. Faysal Ahmed on 25/3/25.
//

import UIKit
import Combine

class WeatherClient {
    let updateWeather = PassthroughSubject<Int, Never>()
    
    func fetchWeather() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self else { return }
            self.updateWeather.send(Int.random(in: 25...55))
        }
    }
}


class ViewController: UIViewController {
    let client = WeatherClient()
    
    @IBAction
    func fetchWeahterButtonAction(_ sender: UIButton) {
        client.fetchWeather()
    }
    
    @IBAction
    func presentToWeatherView(_ sender: UIButton) {
        let vc = WeatherViewController(client: client)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}


//
class WeatherViewController: UIViewController {
    var client: WeatherClient
    private var cancellable: AnyCancellable?
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle(nil, for: .normal)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    init(client: WeatherClient) {
        self.client = client
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        subscribeToWeatherClient()
    }
    
    private func setup() {
        view.backgroundColor = .white
        view.addSubview(temperatureLabel)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            temperatureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            temperatureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            temperatureLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            
        ])
        
    }
    
    private func subscribeToWeatherClient() {
        cancellable = client.updateWeather.sink { [weak self] value in
            guard let self else { return }
            temperatureLabel.text = "\(value)"
            debugPrint("Weather updated. Temp is \(value)")
        }
    }
    
    @objc
    private func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
