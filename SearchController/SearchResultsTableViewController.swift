//
//  SearchResultsTableViewController.swift
//  SearchController
//
//  Created by Ben Chatelain on 5/9/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

import UIKit

/// Shows a list of Swift keywords presented while searching.
class SearchResultsTableViewController: UITableViewController {
    lazy var data: [SwiftKeyword] = SwiftKeyword.allValues
    var filteredData: [SwiftKeyword] = []
    var mainViewController: MainViewController?
}

extension SearchResultsTableViewController {
    /// Filters the results with the given search term.
    ///
    /// - parameter searchTerm: String to use for filtering.
    ///
    /// - returns: Number of results displayed.
    func filterData(searchTerm: String) -> Int {
        defer { tableView.reloadData() }

        let count = searchTerm.characters.count
        debugPrint("searchTerm: \(searchTerm), count: \(count)")
        guard count > 0 else {
            filteredData = data
            return data.count
        }

        filteredData = data.filter { keyword -> Bool in
            keyword.rawValue.rangeOfString(searchTerm.lowercaseString) != nil
        }
        return filteredData.count
    }
}

// MARK: - UITableViewDataSource
extension SearchResultsTableViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.hidden = filteredData.count == 0 ? true : false
        return filteredData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "Keyword")
        cell.textLabel!.text = filteredData[indexPath.row].rawValue
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchResultsTableViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        mainViewController?.showKeyword(filteredData[indexPath.row])
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}