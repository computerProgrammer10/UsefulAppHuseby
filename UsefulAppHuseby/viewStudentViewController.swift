//
//  viewStudentViewController.swift
//  UsefulAppHuseby
//
//  Created by DANIEL HUSEBY on 10/31/24.
//

import UIKit

class viewStudentViewController: UIViewController {

    
    var curStudent: Student!
    
    @IBOutlet weak var studentNameOutlet: UILabel!
    
    @IBOutlet weak var totalSelected: UILabel!
    
    @IBOutlet weak var byTeacherOutlet: UILabel!
    
    @IBOutlet weak var generatedOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        AppData.saveData()
        studentNameOutlet.text = "Chosen Student: \(curStudent.name)"
        totalSelected.text = "Total Times Selected: \(curStudent.generated + curStudent.volunteered)"
        byTeacherOutlet.text = "Chosen By Teacher: \(curStudent.volunteered)"
        generatedOutlet.text = "Chosen By Luck: \(curStudent.generated)"
        // Do any additional setup after loading the view.
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
