//
//  ViewController.swift
//  UsefulAppHuseby
//
//  Created by DANIEL HUSEBY on 10/28/24.
//

import UIKit

class Save: Codable{
    var className: String
    var thisClass: [Student]
    var thisColor: String
    //
    var sortingMethod = 0
    
    init(className: String, thisClass: [Student], thisColor: String) {
        self.className = className
        self.thisClass = thisClass
        self.thisColor = thisColor
    }
    init(){
        self.className = "Default"
        self.thisClass = [Student]()
        self.thisColor = "systemBackground"
    }
    func findColor() -> UIColor{
        var color = thisColor
        var green = "green"
        var yellow = "yellow"
        var red = "red"
        var blue = "blue"
        var black = "black"
        var white = "white"
        if(green == color){
            return .green
        }else if(yellow == color){
            return .yellow
        }else if(red == color){
            return .red
        }else if(blue == color){
            return .systemMint
        }else if(black == color){
            return .black
        }else if(white == color){
            return .white
        }else{
            return .systemBackground
        }
    }
    func sortStudents() -> [Student]{
        switch sortingMethod {
        case 1:
            let alpha = thisClass.sorted { $0.name < $1.name }
            return alpha
        case 2:
            let most = thisClass.sorted { $0.generated + $0.volunteered > $1.generated + $1.volunteered }
            return most
        case 3:
            let least = thisClass.sorted { $0.generated + $0.volunteered < $1.generated + $1.volunteered }
            return least
        default:
            return thisClass
        }
        
    }
//    func mostSelectedStudent() -> Student{
//        var mS: thisClass[0]
//        for s in thisClass{
//            if s.generated + s.volunteered < mS.generated + mS.volunteered{
//                
//            }
//        }
//    }
}

class Student: Codable{
    var name : String
    // how many times a student volunteered to be called on (yay!)
    var volunteered: Int
    // how many times a student was chosen against their will by luck (boooo)
    var generated: Int
    
    init(name: String) {
        self.name = name; self.volunteered = 0; self.generated = 0;
    }
    
    init(){
        name = "Default"
        volunteered = 0
        generated = 0
    }
    func resetData(){
        volunteered = 0; generated = 0;
    }
}

class AppData {
    static var saves = [Save()]
     static var curSlot = 0
    static var curClass = saves[curSlot].thisClass
    static var defaults = UserDefaults.standard
    
    
     static func saveData(){
     if let encoded = try? JSONEncoder().encode(saves){
         defaults.set(encoded, forKey: "Saves")
     }
     
     defaults.set(curSlot, forKey: "curSlot")
     
     }
     
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AppData.saves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! BananaCell
        cell.configure(sSlot: AppData.saves[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppData.curSlot = indexPath.row
        performSegue(withIdentifier: "toClassSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: "Delete?", message: "What do you want to do?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Delete Class", style: .destructive) {(action) in
                AppData.saves.remove(at: indexPath.row)
                self.tableViewOutlet.reloadData()
                AppData.saveData()
            }
            let action2 = UIAlertAction(title: "Reset Student Data", style: .default) {(action) in
                for s in AppData.saves[indexPath.row].thisClass{
                    s.resetData()
                }
                AppData.saveData()
            }
            let action3 = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(action)
            alert.addAction(action2)
            alert.addAction(action3)
            self.present(alert, animated: true)
        }else if editingStyle == .insert{
            AppData.curSlot = indexPath.row
            performSegue(withIdentifier: "classEditSegue", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "More") { action, indexPath in
            let alert = UIAlertController(title: "More Options", message: "What do you want to do?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Delete Class", style: .destructive) {(action) in
                AppData.saves.remove(at: indexPath.row)
                self.tableViewOutlet.reloadData()
                AppData.saveData()
            }
            let action2 = UIAlertAction(title: "Reset Student Data", style: .default) {(action) in
                for s in AppData.saves[indexPath.row].thisClass{
                    s.resetData()
                }
                AppData.saveData()
            }
            let action3 = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(action)
            alert.addAction(action2)
            alert.addAction(action3)
            self.present(alert, animated: true)
        }
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, indexPath in
            let alert = UIAlertController(title: "Edit Class", message: "Type a new name for the class", preferredStyle: .alert)
            alert.addTextField{ (textfield) in
                textfield.placeholder = "Enter Name Here!"
            }
            let action = UIAlertAction(title: "Submit", style: .default) {(action) in
                AppData.saves[indexPath.row].className = alert.textFields![0].text!
                AppData.saveData()
                self.tableViewOutlet.reloadData()
            }
            let action2 = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(action)
            alert.addAction(action2)
            self.present(alert, animated: true)
            
        }
        let view = UITableViewRowAction(style: .normal, title: "View") { action, indexPath in
            AppData.curSlot = indexPath.row
            self.performSegue(withIdentifier: "toSettingsAgain", sender: nil)
            
        }
        view.backgroundColor = UIColor.systemTeal
        edit.backgroundColor = UIColor.systemGreen
        delete.backgroundColor = UIColor.magenta
        return [delete, edit, view]
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        
//        let edit = UITableViewRowAction(style: .normal, title: "Edit Student"){(action, indexPath) in
//            print("Hello!")
//            
//        }
//        return edit
//    }
//    
    
    

    var defaults = UserDefaults.standard
    var decoder = JSONDecoder()
    
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self

        if let blahSaves = defaults.data(forKey: "Saves"){
            if let decoded = try? decoder.decode([Save].self, from: blahSaves){
                AppData.saves = decoded
                AppData.curSlot = defaults.integer(forKey: "curSlot")
                tableViewOutlet.reloadData()
            }
        }else{
            let alert = UIAlertController(title: "Class Name!", message: "Name your first class!", preferredStyle: .alert)
            alert.addTextField{ (textfield) in
                textfield.placeholder = "Enter Name Here!"
            }
            let action = UIAlertAction(title: "Submit", style: .default) {(action) in
                AppData.saves[AppData.curSlot].className = alert.textFields![0].text!
                AppData.saveData()
                self.tableViewOutlet.reloadData()
            }
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableViewOutlet.reloadData()
    }
    
    @IBAction func addAction(_ sender: Any) {
//        print("DANGER DANGER DANGER. WHY? DANGER. DIE DIE DIE. THANSK :D :D :D THANSK")
        let alert = UIAlertController(title: "Class Name!", message: "Name your new class!", preferredStyle: .alert)
        alert.addTextField{ (textfield) in
            textfield.placeholder = "Enter Name Here!"
        }
        let action = UIAlertAction(title: "Submit", style: .default) {(action) in
            var newSave = Save()
            newSave.className = alert.textFields![0].text!
            AppData.saves.append(newSave)
            AppData.saveData()
            self.tableViewOutlet.reloadData()
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        alert.addAction(action2)
        self.present(alert, animated: true)
    }
    
    
    @IBAction func helpAction(_ sender: Any) {
        
            performSegue(withIdentifier: "toHelpSegue", sender: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toClassSegue"{
//            let nvc = segue.destination as! studentsViewController
//        }
//    }

}

