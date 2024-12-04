//
//  settingsViewController.swift
//  UsefulAppHuseby
//
//  Created by DANIEL HUSEBY on 12/3/24.
//

import UIKit

class settingsViewController: UIViewController {

    @IBOutlet weak var resetButtonOutlet: UIButton!
    
    
    @IBOutlet weak var editClassOutlet: UIButton!
    
    @IBOutlet weak var classNameOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        classNameOutlet.text = AppData.saves[AppData.curSlot].className
        resetButtonOutlet.layer.cornerRadius = 10
        editClassOutlet.layer.cornerRadius = 10

//        print("Billy bob")
//        var billyBob = "qwerty"
//        
//        var billyBob2 = billyBob + "asdfghj"
//        var billybobskiller = 7+62
        
        
        // Do any additional setup after loading the view.
    }
    
    func reloadData(){
        classNameOutlet.text = AppData.saves[AppData.curSlot].className
    }
    
    @IBAction func resetButtonAction(_ sender: Any) {
        print("whutt?")
        for s in AppData.saves[AppData.curSlot].thisClass{
            s.resetData()
        }
        AppData.saveData()
        let alert = UIAlertController(title: "Data Reset", message: "Data has been reset", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
    }
    
    
    @IBAction func editClassAction(_ sender: Any) {
        let alert = UIAlertController(title: "Edit Class", message: "Type a new name for the class", preferredStyle: .alert)
        alert.addTextField{ (textfield) in
            textfield.placeholder = "Enter Name Here!"
        }
        let action = UIAlertAction(title: "Submit", style: .default) {(action) in
            AppData.saves[AppData.curSlot].className = alert.textFields![0].text!
            AppData.saveData()
            self.reloadData()
            
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
