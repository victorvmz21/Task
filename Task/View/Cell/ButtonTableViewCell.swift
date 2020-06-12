//
//  TaskListTableViewCell.swift
//  Task
//
//  Created by Victor Monteiro on 6/11/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit
protocol ButtonTableViewCellDelegate: AnyObject {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}

class ButtonTableViewCell: UITableViewCell {

    //MARK: - IBOutlet
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var checkTaskButton: UIButton!
    
    //MARK: Delegate
    weak var delegate: ButtonTableViewCellDelegate?
    
    //MARK: - IBAction
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        delegate?.buttonCellButtonTapped(self)
    }
    
    func updateButton(isComplete: Bool) {
        checkTaskButton.setBackgroundImage(isComplete ? UIImage(systemName: "checkmark.square")
                                                      : UIImage(systemName: "square"), for: .normal)
    }
}

extension ButtonTableViewCell {
    func update(withTask task: Task) {
        taskNameLabel.text = task.name
        updateButton(isComplete: task.isComplete)
    }
}
