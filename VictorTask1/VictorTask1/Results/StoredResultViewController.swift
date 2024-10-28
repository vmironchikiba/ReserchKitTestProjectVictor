//
//  StoredResultViewController.swift
//  VictorTask1
//
//  Created by Mironchik on 28.10.24.
//

import UIKit

class StoredResultViewController: UIViewController {
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var interests: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = SurveyModel.getAll().first {
            firstName.text = user.firstName
            lastName.text = user.lastName
            email.text = user.email
            age.text = user.age.description
            interests.text = user.interest.description
        }
        
        
 
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
