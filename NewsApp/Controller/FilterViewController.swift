//
//  FilterViewController.swift
//  NewsApp
//
//  Created by user on 22.02.2021.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var countrySwicher: UISwitch!
    @IBOutlet weak var categorySwicher: UISwitch!
    
    
    var newsManager = NewsManager()
    var newsVievController : NewsViewController?
    var country = "us"
    var category = "general"
    var picker1Options : [String] = []
    var picker2Options : [String] = []
    
    
    @IBOutlet weak var countryPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPicker.delegate = self
        countryPicker.dataSource = self
        picker1Options = newsManager.countryArray
        picker2Options = newsManager.categoryArray
        
        
    }
    
    @IBAction func countrySwicherPressed(_ sender: UISwitch) {
        if sender.isOn {
            newsVievController?.getCountry(country: country, category: category)
        }
    }
    
    @IBAction func categorySwicherPressed(_ sender: UISwitch) {
        if sender.isOn {
            newsVievController?.getCountry(country: country, category: category)
        }
    }
    
    
}

extension FilterViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return picker1Options.count
        }
        else {
            return picker2Options.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            let code = picker1Options[row]
            let locale = Locale.current
            return locale.localizedString(forRegionCode: code)
        }
        else{
            return picker2Options[row].uppercased()
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            country = picker1Options[row]
            if countrySwicher.isOn {
                newsVievController?.getCountry(country: country, category: category)
            }
            
        }
        else{
            category = picker2Options[row]
            
            if categorySwicher.isOn{
                newsVievController?.getCountry(country: country, category: category)
            }
           
        }
        
        
    }
    
}


