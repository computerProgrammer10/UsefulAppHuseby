//
//  colorViewController.swift
//  UsefulAppHuseby
//
//  Created by DANIEL HUSEBY on 12/10/24.
//

import UIKit

class colorViewController: UIViewController {

    var oldVC: settingsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppData.saves[AppData.curSlot].findColor()
        // Do any additional setup after loading the view.
    }
    
    func changeColor(color: String){
        AppData.saves[AppData.curSlot].thisColor = color
        AppData.saveData()
    }
    
    @IBAction func whiteButton(_ sender: Any) {
        changeColor(color: "systemDefault")
    }
    
    @IBAction func blueButton(_ sender: Any) {
        changeColor(color: "blue")
    }
    
    @IBAction func greenButton(_ sender: Any) {
        changeColor(color: "green")
    }
    
    @IBAction func redButton(_ sender: Any) {
        changeColor(color: "red")
    }
    
    @IBAction func yellowButton(_ sender: Any) {
        changeColor(color: "yellow")
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
