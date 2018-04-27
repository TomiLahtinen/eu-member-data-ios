//
//  CountryDetailViewController.swift
//  eu-member-data
//
//  Created by Tomi Lahtinen on 26/04/2018.
//  Copyright © 2018 Tomi Lahtinen. All rights reserved.
//

import Foundation
import UIKit

class CountryDetailViewController: UIViewController {

    var country: Country!
    var viewModel: CountryViewModel?
    
    var tableViewController: CountryDetailTableViewController?
    
    @IBOutlet weak var flagImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CountryViewModel(country: country)
        populateCountry()
    }
    
    private func populateCountry(){
        if let country = self.country {
            title = country.name[Utils.userLang]
            flagImageView.image = Flag.of(country.code)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embededCountryDetailsSegue" {
            let vc = segue.destination as! CountryDetailTableViewController
            vc.country = country
        }
    }
}

class CountryDetailTableViewController: UITableViewController {
    
    private let actionableCell = "actionableCell"
    private let nonActionableCell = "nonActionableCell"
    
    var country: Country!
    var viewModel: CountryViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CountryViewModel(country: country)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        debugPrint("sections", Section.count)
        return Section.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else {
            return 0
        }
        let data = viewModel.data(in: Section(rawValue: section)!)
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section(rawValue: section)!.caption()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel?.data(in: Section(rawValue: indexPath.section)!)
        debugPrint("data in section", indexPath.section, data)
        let countryDataRow = data![indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: countryDataRow.actionable ? actionableCell : nonActionableCell)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value2, reuseIdentifier: countryDataRow.actionable ? actionableCell : nonActionableCell)
            if countryDataRow.actionable {
                cell?.accessoryType = UITableViewCellAccessoryType.detailButton
            }
        }
        cell?.textLabel?.text = countryDataRow.title
        cell?.detailTextLabel?.text = countryDataRow.value
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let data = viewModel?.data(in: Section(rawValue: indexPath.section)!)
        let dataRow = data![indexPath.row]
        if dataRow.title == "Name" {
            instantiateAndPresentMapView()
        }
        if dataRow.title == "Wikipedia" {
            instantiateAndPresentWikipediaView()
        }
    }
    
    private func instantiateAndPresentMapView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "mapViewController")
        guard let mapViewController = controller as? MapViewController else {
            debugPrint("We have some serious issues with MapViewController")
            fatalError()
        }
        mapViewController.country = self.country
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    private func instantiateAndPresentWikipediaView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "wikipediaViewController")
        guard let wikiVC = controller as? WikipediaViewController else {
            debugPrint("We have some serious issues with WikipediaViewController")
            fatalError()
        }
        wikiVC.country = self.country
        self.navigationController?.pushViewController(wikiVC, animated: true)
    }
}
