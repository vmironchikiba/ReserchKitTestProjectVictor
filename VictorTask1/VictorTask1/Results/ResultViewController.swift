//
//  ResultViewController.swift
//  VictorTask1
//
//  Created by Mironchik on 26.10.24.
//


import UIKit
import ResearchKit

class ResultViewController: UITableViewController {
    
    enum SegueIdentifier: String {
        case showTaskResult = "ShowTaskResult"
    }

    var result: ORKResult?

    var currentResult: ORKResult?

    var resultTableViewProvider: UITableViewDataSource & UITableViewDelegate = resultTableViewProviderForResult(nil, delegate: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            self.tableView.backgroundColor = UIColor.systemGroupedBackground
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        currentResult = result

        resultTableViewProvider = resultTableViewProviderForResult(result, delegate: self)
        
        tableView.dataSource = resultTableViewProvider
        tableView.delegate = resultTableViewProvider
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let identifier = segue.identifier,
               let segueIdentifier = SegueIdentifier(rawValue: identifier), segueIdentifier == .showTaskResult {
            
            let cell = sender as! UITableViewCell
            
            let indexPath = tableView.indexPath(for: cell)!
            
            let destinationViewController = segue.destination as! ResultViewController
            
            let collectionResult = result as! ORKCollectionResult
            
            destinationViewController.result = collectionResult.results![(indexPath as NSIndexPath).row]
        }
    }

    override func shouldPerformSegue(withIdentifier segueIdentifier: String?, sender: Any?) -> Bool {

        if let cell = sender as? UITableViewCell {
            return cell.accessoryType == .disclosureIndicator
        }
        
        return false
    }
}

extension ResultViewController: ResultProviderDelegate {
    func presentShareSheet(shareSheet: UIActivityViewController) {
        present(shareSheet, animated: true, completion: nil)
    }
}

