//
//  SearchBarDelegate.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/25/24.
//

import UIKit

extension ActivityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count < 2 {
            filteredReportedActivities = reportedActivities
        } else {
            let filterText = searchText.lowercased()
            filteredReportedActivities = reportedActivities.filter {
                let textToSearch = ($0.address ?? "") + $0.nature
                return textToSearch.lowercased().contains(filterText)
            }
        }
        
        clearPlacemarksFromMap()
        Task {
            await addPlacemarksToMap(activities: filteredReportedActivities)
        }
        activityCollectionView.reloadData()
    }
}
