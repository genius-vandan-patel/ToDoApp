//
//  ToDoCellTableViewCell.swift
//  ToDoApp
//
//  Created by Vandan Patel on 12/14/17.
//  Copyright © 2017 Vandan Patel. All rights reserved.
//

import UIKit

protocol ToDoCellDelegate {
    func didRequestDelete(_ cell: ToDoCell)
    func didRequestComplete(_ cell: ToDoCell)
}

class ToDoCell: UITableViewCell {

    @IBOutlet weak var toDoLabel: UILabel!
    var delegate: ToDoCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func didTapComplete(_ sender: UIButton) {
        if let delegateObject = self.delegate {
            delegateObject.didRequestComplete(self)
        }
    }
    
    @IBAction func didTapDelete(_ sender: UIButton) {
        if let delegateObject = self.delegate {
            delegateObject.didRequestDelete(self)
        }
    }
}
