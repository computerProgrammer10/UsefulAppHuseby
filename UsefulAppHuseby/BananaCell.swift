//
//  YummyCell.swift
//  UsefulAppHuseby
//
//  Created by DANIEL HUSEBY on 10/30/24.
//

import Foundation


import UIKit
class BananaCell: UITableViewCell{
    
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var studentCountLabel: UILabel!
    func configure(sSlot: Save){
        classNameLabel.text = sSlot.className
        studentCountLabel.text = "\(sSlot.thisClass.count) students"
    }
}
