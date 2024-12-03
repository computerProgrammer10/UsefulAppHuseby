//
//  studentsViewController.swift
//  UsefulAppHuseby
//
//  Created by DANIEL HUSEBY on 10/30/24.
//

import UIKit

class studentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AppData.saves[AppData.curSlot].thisClass.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! YummyCell
        cell.configure(sStudent: AppData.saves[AppData.curSlot].thisClass[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        curStudent = AppData.saves[AppData.curSlot].thisClass[indexPath.row]
        curStudent.volunteered+=1
        performSegue(withIdentifier: "viewStudentSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: "Delete?", message: "What do you want to do?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Delete Student", style: .destructive) {(action) in
                AppData.saves[AppData.curSlot].thisClass.remove(at: indexPath.row)
                self.tableViewOutlet.reloadData()
                AppData.saveData()
            }
            let action2 = UIAlertAction(title: "Reset Student Data", style: .default) {(action) in
                AppData.saves[AppData.curSlot].thisClass[indexPath.row].resetData()
                self.tableViewOutlet.reloadData()
                AppData.saveData()
            }
            let action3 = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(action)
            alert.addAction(action2)
            alert.addAction(action3)
            self.present(alert, animated: true)
        }else if editingStyle == .insert{
            curStudent = AppData.saves[AppData.curSlot].thisClass[indexPath.row]
            performSegue(withIdentifier: "alsoEditSegue", sender: nil)
        }
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "More") { action, indexPath in
            let alert = UIAlertController(title: "More Options", message: "What do you want to do?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Delete Student", style: .destructive) {(action) in
                AppData.saves[AppData.curSlot].thisClass.remove(at: indexPath.row)
                self.tableViewOutlet.reloadData()
                AppData.saveData()
            }
            let action2 = UIAlertAction(title: "Reset Student Data", style: .default) {(action) in
                AppData.saves[AppData.curSlot].thisClass[indexPath.row].resetData()
                self.tableViewOutlet.reloadData()
                AppData.saveData()
            }
            let action3 = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(action)
            alert.addAction(action2)
            alert.addAction(action3)
            self.present(alert, animated: true)
        }
        let edit = UITableViewRowAction(style: .default, title: "Edit") { action, indexPath in
            let alert = UIAlertController(title: "Edit Student", message: "Type a new name for the student", preferredStyle: .alert)
            alert.addTextField{ (textfield) in
                textfield.placeholder = "Enter Name Here!"
            }
            let action = UIAlertAction(title: "Submit", style: .default) {(action) in
                AppData.saves[AppData.curSlot].thisClass[indexPath.row].name = alert.textFields![0].text!
                AppData.saveData()
                self.tableViewOutlet.reloadData()
            }
            let action2 = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(action)
            alert.addAction(action2)
            self.present(alert, animated: true)
            
        }
        delete.backgroundColor = .purple
        edit.backgroundColor = .blue
        return [delete, edit]
    }
    
    
    var curStudent = Student()
    
    @IBOutlet weak var randomButtonOutlet: UIButton!
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        randomButtonOutlet.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableViewOutlet.reloadData()
    }
    
    @IBAction func randomStudentAction(_ sender: Any) {
        if AppData.saves[AppData.curSlot].thisClass.count != 0{
            curStudent = AppData.saves[AppData.curSlot].thisClass[Int.random(in: 0...AppData.saves[AppData.curSlot].thisClass.count-1)]
            curStudent.generated+=1
            performSegue(withIdentifier: "viewStudentSegue", sender: nil)
        }else{
            createAlert(alertTitle: "No Students", alertDesc: "You must add at least one student for this to do something")
        }
    }
    
    @IBAction func addStudent(_ sender: Any) {
        let alert = UIAlertController(title: "New Student!", message: "What's your student's name?", preferredStyle: .alert)
        alert.addTextField{ (textfield) in
            textfield.placeholder = "Enter Name Here!"
        }
        let action = UIAlertAction(title: "Submit", style: .default) {(action) in
            var newStudent = Student()
            newStudent.name = alert.textFields![0].text!
            AppData.saves[AppData.curSlot].thisClass.append(newStudent)
            AppData.saveData()
            self.tableViewOutlet.reloadData()
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        alert.addAction(action2)
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewStudentSegue"{
            let nvc = segue.destination as! viewStudentViewController
            nvc.curStudent = self.curStudent
        }
    }
    
    
    @IBAction func settingsAction(_ sender: Any) {
        performSegue(withIdentifier: "toSettings", sender: nil)
    }
    
    func createAlert(alertTitle: String, alertDesc: String){
        let alert = UIAlertController(title: alertTitle, message: alertDesc, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
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
