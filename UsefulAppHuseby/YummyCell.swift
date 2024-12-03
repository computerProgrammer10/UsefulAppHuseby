//
//  YummyCell.swift
//  UsefulAppHuseby
//
//  Created by DANIEL HUSEBY on 10/30/24.
//

import Foundation


import UIKit
class YummyCell: UITableViewCell{
    
    @IBOutlet weak var nameOutlet: UILabel!
    
    @IBOutlet weak var timesChosenOutlet: UILabel!
    
    @IBOutlet weak var timesChosenRandom: UILabel!
    func configure(sStudent: Student){
        nameOutlet.text = sStudent.name
        timesChosenOutlet.text = "Chosen \( sStudent.volunteered) time(s) by teacher"
        timesChosenRandom.text = "Chosen \( sStudent.generated) time(s) by luck"
    }
}
