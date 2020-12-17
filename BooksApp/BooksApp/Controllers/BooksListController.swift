//
//  BooksListController.swift
//  BooksApp
//
//  Created by Apple on 17/12/20.
//  Copyright © 2020 Assignment. All rights reserved.
//

import UIKit

class BooksListController: UITableViewController {

    @IBOutlet weak var changeDateBtn: UIBarButtonItem!
    
    // variable declaration
    var listOfBooksArr: [Book] = []
    var filteredBooks: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func changeDate(_ sender: UIBarButtonItem) {
      
    }
    
    // table view
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookTableViewCell
        
        cell.titleLbl.text = "title"
        cell.authorLbl.text = "author"
        cell.publisherLbl.text = "publisher"
        cell.contributorLbl.text = "contributor"
        cell.descriptionLbl.text = "description"
        return cell
    }
}

