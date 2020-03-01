//
//  CountryDetailViewController.swift
//  Countries
//
//  Created by Mandar Wankhede New on 29/02/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

import UIKit
import WebKit

fileprivate struct Constants {
    static var numberOfRows = 7
}

class CountryDetailViewController: UIViewController {
    @IBOutlet weak var flagWebView: WKWebView!    
    @IBOutlet weak var countryDetailsTableView: UITableView!
    private var countryToDisplay: CountryModel?
    var countryPresenter: CountryPresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPresenter?.loadCountryDetails()
    }

    @IBAction func saveCountry(_ sender: Any) {
        countryPresenter?.saveCountry()
    }
}

extension CountryDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryintocellid", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = NSLocalizedString("Capital", comment: "")
            cell.detailTextLabel?.text = countryToDisplay?.capital
        case 1:
            cell.textLabel?.text = NSLocalizedString("Region", comment: "")
            cell.detailTextLabel?.text = countryToDisplay?.region
        case 2:
            cell.textLabel?.text = NSLocalizedString("SubRegion", comment: "")
            cell.detailTextLabel?.text = countryToDisplay?.subRegion
        case 3:
            cell.textLabel?.text = NSLocalizedString("SubRegion", comment: "")
            cell.detailTextLabel?.text = "\(countryToDisplay?.subRegion ?? "")"
        case 4:
            cell.textLabel?.text = NSLocalizedString("Calling Codes", comment: "")
            cell.detailTextLabel?.text = "\(countryToDisplay?.callingCodes.joined(separator: ", ") ?? "")"
        case 5:
            let languages = countryToDisplay?.languages.map{ $0.nativeName }
            cell.textLabel?.text = NSLocalizedString("Languages", comment: "")
            cell.detailTextLabel?.text = "\(languages?.joined(separator: ",") ?? "")"
        case 6:
            cell.textLabel?.text = NSLocalizedString("Timezones", comment: "")
            cell.detailTextLabel?.text = "\(countryToDisplay?.timezones.joined(separator: ", ") ?? "")"
        default:
            cell.textLabel?.text = "-"
        }
        cell.detailTextLabel?.textColor = UIColor.darkGray
        return cell
    }
}

extension CountryDetailViewController: CountryViewable {
    func setCountry(country: CountryModel) {
        title = country.countryName
        flagWebView.loadHTMLString(country.flag ?? "", baseURL: nil)
        countryToDisplay = country
    }

    func showToast(message: String) {
        let toast = MBProgressHUD.showAdded(to: self.view, animated: true)
        toast.label.text = message
        toast.mode = .text
        toast.hide(animated: true, afterDelay: 2)
    }
}
