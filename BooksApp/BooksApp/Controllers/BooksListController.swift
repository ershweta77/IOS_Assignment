//
//  BooksListController.swift
//  BooksApp
//
//  Created by Apple on 17/12/20.
//  Copyright © 2020 Assignment. All rights reserved.
//

import UIKit

class BooksListController: UITableViewController, UISearchControllerDelegate,UISearchBarDelegate {

    @IBOutlet weak var changeDateBtn: UIBarButtonItem!
    
    // variable declaration
    var listOfBooksArr: [String] = []
    var filteredBooks: [String] = []
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUpSearchViewController()
    }
    func setUpSearchViewController(){
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Books"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        filteredBooks = listOfBooksArr.filter {(book : String) -> Bool in
            return book.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    @IBAction func changeDate(_ sender: UIBarButtonItem) {
      
    }
    
    // table view
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    if isFiltering
//    {
//        return filteredBooks.count
//    }
//    return listOfBooksArr.count
        return 1
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookTableViewCell
        
        if isFiltering {
            
            print("filtered array")
        }else
        {
            print("all objects")
        }
        cell.titleLbl.text = "title"
        cell.authorLbl.text = "author"
        cell.publisherLbl.text = "publisher"
        cell.contributorLbl.text = "contributor"
        cell.descriptionLbl.text = "description"
        return cell
    }
    
    
}

extension BooksListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
