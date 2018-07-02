//
//  UserListViewController.swift
//  TestApp
//
//  Created by Rebekah Baker on 7/1/18.
//  Copyright © 2018 Bekah Baker. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HighlightButtonDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users = [User]()
    var previousSelectedRowIndex = -1
    var selectedRowIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
        APIClient.request(endpoint: UserEndpoints.getUsers(countOf: 25)) { (response) in
            if response != nil {
                self.users = response!
                self.tableView.reloadData()
            } else {
                print("ERROR MAKING REQUEST FOR USERS")
            }
        }
        
        // TODO: Setup tableview, populate with user list
        
        // Setup user detail view, send user through
    }
    
    // MARK: TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        let user = users[indexPath.row]
        cell.selectionStyle = .none
        cell.delegate = self
        cell.indexPath = indexPath
        cell.isSelected = selectedRowIndex == indexPath.row
        cell.configureCell(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedRowIndex {
            return 130 //Expanded
        }
        return 100 //Not expanded
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        print("SELECTED CELL ", cell.nameLabel.text)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Don't transform previously selected index
        if indexPath.row != previousSelectedRowIndex {
            cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.5) {
                cell.transform = CGAffineTransform.identity
            }
        }
    }
    
    // MARK: HighlightButtonDelegate
    func cellIndexTapped(at index: IndexPath) {
        // Saves last tapped index for reloading
        previousSelectedRowIndex = selectedRowIndex
        let previousIndex: IndexPath = [0, selectedRowIndex]
        
        // Sets new selected index
        if selectedRowIndex == index.row {
            selectedRowIndex = -1
        } else {
            selectedRowIndex = index.row
        }
        
        // Reloads new index and previous
        self.tableView.reloadRows(at: [index, previousIndex], with: .automatic)
    }
}
