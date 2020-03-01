//
//  CountriesTableViewController.swift
//  Countries
//
//  Created by Mandar Wankhede New on 29/02/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

import UIKit
import Combine

fileprivate struct Constants {
    fileprivate static let countryCellId = "countryCell"
    fileprivate static let countryDetailSegueId = "todetailcountryvc"
}

class CountriesTableViewController: UITableViewController {
    private var countriesToDisplay = [CountryModel]() {
        didSet {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    private var selectedCountry: CountryModel?
    private var resultSearchController: UISearchController?
    var countriesPresenter: CountriesPresentable = CountriesPresenter(networkService: NetworkManager(), databaseService: CoreDataService())

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        countriesPresenter.countriesView = self
    }

    private func configureSearchBar() {
        resultSearchController = UISearchController(searchResultsController: nil)
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = resultSearchController?.searchBar
        seatupSearchbarListner()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.countryDetailSegueId,
            let controller = segue.destination as? CountryDetailViewController {
            let countryPresenter = CountryPresenter(countryModel: selectedCountry, databaseService: CoreDataService())
            countryPresenter.countriesView = controller
            controller.countryPresenter = countryPresenter
        }
    }

    private func seatupSearchbarListner() {
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: resultSearchController?.searchBar.searchTextField)
        _ = publisher.map ({
            ($0.object as! UISearchTextField).text!
        }).debounce(for: .milliseconds(500), scheduler: RunLoop.main)
          .removeDuplicates()
          .sink{ searchText in
            self.countriesPresenter.fetchCountries(by: searchText)
        }
    }
}

// MARK: - Table view data source and delegate
extension CountriesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countriesToDisplay.isEmpty ? tableView.setEmptyContentMessage(message: NSLocalizedString("No_Countries_Text", comment: "")) :
            tableView.restore()
        return countriesToDisplay.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.countryCellId, for: indexPath) as! CountryTableViewCell
        cell.country = countriesToDisplay[indexPath.row]
        cell.delegate = self
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCountry = countriesToDisplay[indexPath.row]
        performSegue(withIdentifier: Constants.countryDetailSegueId, sender: self)
    }
}

// MARK: - CustomCellDelegate
extension CountriesTableViewController: CustomCellDelegate {
    func didUpdateObject(for cell: UITableViewCell) {
        DispatchQueue.main.async { [weak self] in
            if let indexPath = self?.tableView.indexPath(for: cell) {
                self?.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
    }
}

// MARK: - CountriesViewable
extension CountriesTableViewController: CountriesViewable {
    func setCountries(countries: [CountryModel]) {
        countriesToDisplay = countries
    }

    func setEmptyContentView() {
        countriesToDisplay.removeAll()
    }
}
