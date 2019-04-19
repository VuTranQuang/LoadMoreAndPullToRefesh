//
//  TableViewController.swift
//  LoadMoreAndPullToFresh
//
//  Created by Vũ on 11/30/18.
//  Copyright © 2018 Vũ. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet weak var acInView: UIActivityIndicatorView!
    var number = [1, 3]
    let reFresh = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = reFresh
        refreshControl?.tintColor = .red
        reFresh.addTarget(self, action: #selector(reFreshData), for: .valueChanged)
        tableView.addSubview(reFresh)
    }
    
    @objc
    func reFreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            
            self.number = [self.number.removeFirst()]
        self.refreshControl?.endRefreshing()
        self.tableView.reloadData()
        }
    }
  

  

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return number.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(number[indexPath.row])"
        
        return cell
    }
   override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let deleteLine = UITableViewHeaderFooterView()
        let lastItem = number.count - 1
    if indexPath.row == lastItem {
 
        acInView.startAnimating()
        loadMore()
        
    }
    }
    func loadMore() {
        let lastItem = number.last!
        let newItem = lastItem + 1
        number.append(newItem)
    
        tableView.reloadData()
    }
  

}
