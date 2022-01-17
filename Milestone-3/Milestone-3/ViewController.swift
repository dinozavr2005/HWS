//
//  ViewController.swift
//  Milestone-3
//
//  Created by Владимир on 16.01.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var shopingList: [String] = []
    var tempList: [String] = ["nothing here yet"]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem)),
                                              UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))]
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(cleanList))
        
        title = "Shopping list"
        
        if shopingList.isEmpty {
            return shopingList = tempList
        
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopingList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopCell", for: indexPath)
        cell.textLabel?.text = shopingList[indexPath.row]
        return cell
    }
    
    func submit(answer: String) {
        if shopingList == tempList {
            shopingList.removeAll()
        }
        shopingList.append(answer)
        tableView.reloadData()
    }
    // MARK: - Selectors
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer =  ac?.textFields?[0].text else { return }
            self?.submit(answer: answer)
            
        }
        let dissmisAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        ac.addAction(dissmisAction)
    }
    
    @objc func shareTapped() {
            let list = shopingList.joined(separator: "\n")
            
            let avc = UIActivityViewController(activityItems: [list], applicationActivities: nil)
            avc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(avc, animated: true)
        }
    
    @objc func cleanList() {
        shopingList.removeAll()
        tableView.reloadData()
    }

}
