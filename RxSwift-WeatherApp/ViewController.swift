//
//  ViewController.swift
//  RxSwift-WeatherApp
//
//  Created by Aleksander Waage on 31/07/2020.
//  Copyright © 2020 Waageweb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTexField: UITextField!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.cityNameTexField.rx.controlEvent(.editingDidEndOnExit).asObservable()
            .map { self.cityNameTexField.text }
            .subscribe(onNext: { city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    }else{
                        self.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)
        
    }
    
    private func displayWeather(_ weather: Weather?){
        if let weather = weather {
            self.tempratureLabel.text = "\(weather.temp) ℃"
            self.humidityLabel.text = "\(weather.humidity) ☔︎"
        }else {
            self.tempratureLabel.text = "🚫"
            self.humidityLabel.text = "🚫"
        }
    }
    
    private func fetchWeather(by city: String){
        
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let url = URL.urlForWeatherAPI(city: cityEncoded) else { return }
        
        let resource = Resource<WeaterResult>(url: url)

        /* Using load function with catching errors and retry */
        let search = URLRequest.load(resource: resource)
        .observeOn(MainScheduler.instance)
        .retry(3)
        .catchError { error in
            print(error.localizedDescription)
            return Observable.just(WeaterResult.empty)
        }.asDriver(onErrorJustReturn: WeaterResult.empty)
        
        /* Using load function without catching error
        let search = URLRequest.load(resource: resource)
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: WeaterResult.empty)
         */
 
        search.map { "\($0.main.temp) ℃" }
        .drive(self.tempratureLabel.rx.text)
        .disposed(by: disposeBag)
        
        search.map { "\($0.main.humidity) ☔︎" }
        .drive(self.humidityLabel.rx.text)
        .disposed(by: disposeBag)
    }


}

