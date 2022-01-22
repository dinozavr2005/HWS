//
//  ViewController.swift
//  HWSMilestone-6
//
//  Created by Владимир on 21.01.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries: [Country] = Bundle.main.decode("Sample.json")
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Country facts"
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        
        guard let cell = reusableCell as? CountryCell else {
            return reusableCell
        }
        
        let country = countries[indexPath.row]
        
        cell.flagImageView?.image = UIImage(named: getFlagFileName(code: country.alpha2Code, type: .SD))
        cell.flagImageView?.layer.borderColor = UIColor.black.cgColor
        cell.flagImageView?.layer.borderWidth = 0.1
        cell.flagImageView?.layer.cornerRadius = 5
        cell.nameLabel.text = country.name
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.country = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
