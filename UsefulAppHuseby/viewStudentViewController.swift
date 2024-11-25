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
        updateStudentInfo()
        // Do any additional setup after loading the view.
    }
    
    func updateStudentInfo(){
        AppData.saveData()
        studentNameOutlet.text = "Chosen Student: \(curStudent.name)"
        totalSelected.text = "Total Times Selected: \(curStudent.generated + curStudent.volunteered)"
        byTeacherOutlet.text = "Chosen By Teacher: \(curStudent.volunteered)"
        generatedOutlet.text = "Chosen By Luck: \(curStudent.generated)"
    }
    
    @IBAction func editAction(_ sender: Any) {
        let alert = UIAlertController(title: "Edit Student", message: "Type a new name for the student", preferredStyle: .alert)
        alert.addTextField{ (textfield) in
            textfield.placeholder = "Enter Name Here!"
        }
        let action = UIAlertAction(title: "Submit", style: .default) {(action) in
            self.curStudent.name = alert.textFields![0].text!
            self.updateStudentInfo()
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        alert.addAction(action2)
        self.present(alert, animated: true)
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
