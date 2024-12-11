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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func systemButton(_ sender: UIButton) {
        AppData.saves[AppData.curSlot].thisColor = "white"
    }
    @IBAction func blueButton(_ sender: UIButton) {
        AppData.saves[AppData.curSlot].thisColor = "blue"
    }
    @IBAction func greenButton(_ sender: Any) {
        AppData.saves[AppData.curSlot].thisColor = "green"
    }
    @IBAction func redButton(_ sender: Any) {
        AppData.saves[AppData.curSlot].thisColor = "red"
    }
    @IBAction func yellowButton(_ sender: Any) {
        AppData.saves[AppData.curSlot].thisColor = "yellow"
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
