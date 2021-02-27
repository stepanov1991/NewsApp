//
//  FilterViewController.swift
//  NewsApp
//
//  Created by user on 22.02.2021.
//

import UIKit

class FilterViewController: UIViewController {
    
    var newsManager = NewsManager()
    var newsVievController : NewsViewController?
    var country : String = ""
    
    
    @IBOutlet weak var countryPicker: UIPickerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        countryPicker.delegate = self
        countryPicker.dataSource = self
        
//        var filderCountryData: [CountryFilter] = []
//
//        filderCountryData.append(
//            CountryFilter(code: "ua", name: "Ukraine")
//        )
        
//        let locale = Locale(identifier: "ua") // Country names in Spanish
//        let countryName = locale.localizedString(forRegionCode: "ua")

        
    }
    

    

}

extension FilterViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return newsManager.countryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let code = newsManager.countryArray[row]
        let locale = Locale.current
        return locale.localizedString(forRegionCode: code)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        country = newsManager.countryArray[row]
        newsVievController?.getCountry(country: country)
       
    }
    
}

//class CountryFilter {
//    let code: String
//    let name: String
//
//    init(code: String, name: String) {
//        self.code = code
//        self.name = name
//    }
//}
