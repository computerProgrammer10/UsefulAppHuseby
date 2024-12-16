//
//  studentsViewController.swift
//  UsefulAppHuseby
//
//  Created by DANIEL HUSEBY on 10/30/24.
//
// MARK: - DANIEL IS THE GOAT.



// MARK: - SEAVER IS A PONY




// MARK: - JOHNS JUST HERE :0
import UIKit

class studentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AppData.saves[AppData.curSlot].thisClass.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! YummyCell
        cell.configure(sStudent: usedClass[indexPath.row])
        cell.backgroundColor = AppData.saves[AppData.curSlot].findColor()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        curStudent = self.usedClass[indexPath.row]
        curStudent.volunteered+=1
        performSegue(withIdentifier: "viewStudentSegue", sender: nil)
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//            let alert = UIAlertController(title: "Delete?", message: "What do you want to do?", preferredStyle: .alert)
//            let action = UIAlertAction(title: "Delete Student", style: .destructive) {(action) in
//                AppData.saves[AppData.curSlot].thisClass.remove(at: indexPath.row)
//                self.tableViewOutlet.reloadData()
//                AppData.saveData()
//            }
//            let action2 = UIAlertAction(title: "Reset Student Data", style: .default) {(action) in
//                AppData.saves[AppData.curSlot].thisClass[indexPath.row].resetData()
//                self.tableViewOutlet.reloadData()
//                AppData.saveData()
//            }
//            let action3 = UIAlertAction(title: "Cancel", style: .cancel)
//            alert.addAction(action)
//            alert.addAction(action2)
//            alert.addAction(action3)
//            self.present(alert, animated: true)
//        }else if editingStyle == .insert{
//            curStudent = AppData.saves[AppData.curSlot].thisClass[indexPath.row]
//            performSegue(withIdentifier: "alsoEditSegue", sender: nil)
//        }
//    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "More") { action, indexPath in
            let alert = UIAlertController(title: "More Options", message: "What do you want to do?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Delete Student", style: .destructive) {(action) in
                var studentToDelete = self.usedClass[indexPath.row]
                // make this work somehow?????
                for s in 0...AppData.saves[AppData.curSlot].thisClass.count{
                    if AppData.saves[AppData.curSlot].thisClass[s] === studentToDelete{
                        AppData.saves[AppData.curSlot].thisClass.remove(at: s)
                        self.updateStuff()
                        break
                    }
                }
            }
            let action2 = UIAlertAction(title: "Reset Student Data", style: .default) {(action) in
                self.usedClass[indexPath.row].resetData()
                self.updateStuff()
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
                self.usedClass[indexPath.row].name = alert.textFields![0].text!
                self.updateStuff()
            }
            let action2 = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(action)
            alert.addAction(action2)
            self.present(alert, animated: true)
            
        }
        let view = UITableViewRowAction(style: .normal, title: "View") { action, indexPath in
            self.curStudent = self.usedClass[indexPath.row]
            self.performSegue(withIdentifier: "viewStudentSegue", sender: nil)
            
        }
        view.backgroundColor = UIColor.systemTeal
        edit.backgroundColor = UIColor.systemGreen
        delete.backgroundColor = UIColor.magenta
        return [delete, edit, view]
    }
    
    
    var curStudent = Student()
    
    var usedClass = AppData.saves[AppData.curSlot].sortStudents()
    
    @IBOutlet weak var randomButtonOutlet: UIButton!
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    @IBOutlet weak var sortedTextOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        randomButtonOutlet.layer.cornerRadius = 10
        

        // Do any additional setup after loading the view.
    }
    
    
//    func findColor(color: String){
//        var green = "green"
//        var yellow = "yellow"
//        var red = "red"
//        var blue = "blue"
//        var black = "black"
//        var white = "white"
//        if(green == color){
//            tableViewOutlet.backgroundColor = .green
//        }else if(yellow == color){
//            tableViewOutlet.backgroundColor = .yellow
//        }else if(red == color){
//            tableViewOutlet.backgroundColor = .red
//        }else if(blue == color){
//            tableViewOutlet.backgroundColor = .blue
//        }else if(black == color){
//            tableViewOutlet.backgroundColor = .black
//        }else if(white == color){
//            tableViewOutlet.backgroundColor = .white
//        }else{
//            print("No color called")
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateStuff()
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
            self.updateStuff()
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
    // MARK: - Sorting Button
    @IBAction func sortTabButtom(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Sorting Menu", message: "How do you want to sort?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Alphabetical", style: .default) {(action) in
            AppData.saves[AppData.curSlot].sortingMethod = 1
            self.updateStuff()
        }
        let action2 = UIAlertAction(title: "Most Picked", style: .default) {(action) in
            AppData.saves[AppData.curSlot].sortingMethod = 2
            self.updateStuff()
        }
        let action3 = UIAlertAction(title: "Least Picked", style: .default) {(action) in
            AppData.saves[AppData.curSlot].sortingMethod = 3
            self.updateStuff()
        }
        let action4 = UIAlertAction(title: "Cancel", style: .destructive) {(action) in
        }
        let action5 = UIAlertAction(title: "Reset to Default", style: .cancel) {(action) in
            AppData.saves[AppData.curSlot].sortingMethod = 0
            self.updateStuff()
        }
        alert.addAction(action)
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(action5)
        alert.addAction(action4)
        self.present(alert, animated: true)
    }
    
    func updateStuff(){
        AppData.saveData()
        switch AppData.saves[AppData.curSlot].sortingMethod{
        case 1:
            self.sortedTextOutlet.text = "Sorted by Alphabetical"
        case 2:
            self.sortedTextOutlet.text = "Sorted by Most Picked"
        case 3:
            self.sortedTextOutlet.text = "Sorted by Least Picked"

        default:
            self.sortedTextOutlet.text = ""
        }
        self.usedClass = AppData.saves[AppData.curSlot].sortStudents()
        self.tableViewOutlet.reloadData()
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
