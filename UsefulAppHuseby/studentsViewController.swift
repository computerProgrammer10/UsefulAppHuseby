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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
