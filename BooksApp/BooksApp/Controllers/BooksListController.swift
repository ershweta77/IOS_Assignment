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
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerBackgoundView: UIView!
    // variable declaration
    var listOfBooksArr: [Book] = []
    var filteredBooks: [Book] = []
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 160
        
        // current date
        let date = Date()
        self.getBooks(dateStr: self.getDateFormatter().string(from: date))
    }
    func setUpSearchViewController(){
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Books"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredBooks = listOfBooksArr.filter { (book: Book) -> Bool in
            return book.title.lowercased().contains(searchText.lowercased()) ||         book.description.lowercased().contains(searchText.lowercased()) ||
                book.author.lowercased().contains(searchText.lowercased()) ||
                book.publisher.lowercased().contains(searchText.lowercased()) ||
                book.contributor.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    @IBAction func changeDate(_ sender: UIBarButtonItem) {
        datePickerBackgoundView.isHidden = false
    }
    
    @IBAction func datePickerValueChanged(sender: UIDatePicker) {
        // Function will be called every time picker changes it's value
        self.getBooks(dateStr: self.getDateFormatter().string(from: sender.date))
        datePickerBackgoundView.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    
    func getDateFormatter() -> DateFormatter
    {
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "yyyy-MM-dd"
     return dateFormatter
    }

    func getBooks(dateStr:String){
        BooksInt.init().getListOfBooks(date:dateStr) {  (result: Result<Response, Error>) in
            switch result {
            case .success(let response):
                var books:[Book] = []
                for list in response.results.lists{
                    for book in list.books{
                        books.append(book)
                    }
                }
                self.listOfBooksArr = books
                print("list of books\(self.listOfBooksArr.count)")
            case .failure(let error):
                print(error)
                self.listOfBooksArr.removeAll()
            }
            
            self.tableView.reloadData()
        }
    }
    // table view
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering
    {
        return filteredBooks.count
    }
    return listOfBooksArr.count
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookTableViewCell
        
        let book: Book
        if isFiltering {
            book = filteredBooks[indexPath.row]
        } else {
            book = listOfBooksArr[indexPath.row]
        }
        cell.titleLbl.text = book.title
        cell.authorLbl.text = book.author
        cell.publisherLbl.text = book.publisher
        cell.contributorLbl.text = book.contributor
        cell.descriptionLbl.text = book.description
        return cell
    }
    
    
}

extension BooksListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
