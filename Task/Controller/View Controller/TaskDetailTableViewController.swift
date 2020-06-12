//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Victor Monteiro on 6/11/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    
    //MARK: - Properties
    var tasks: Task?
    var dueDateValue: Date?
    
    //MARK: VIew Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        dueDateTextField.inputView = datePicker
        taskNameTextField.delegate = self
        dueDateTextField.delegate = self
        notesTextView.delegate = self
    }

    //MARK: -  IBActions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let taskName = taskNameTextField.text, !taskName.isEmpty else { return }
        guard let dueDate = dueDateTextField.text, !dueDate.isEmpty else { return }
        guard let notes = notesTextView.text, !notes.isEmpty else { return }
        
        if let task = tasks {
            TaskController.shared.update(task: task, name: taskName, notes: notes, due: datePicker.date)
        } else {
            TaskController.shared.add(taskWithName: taskName, notes: notes, due: datePicker.date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func canceButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueDateTextField.text = datePicker.date.stringValue()
    }
    
    //MARK: - Methods
    func setupTextFields() {
        let toolBar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: 30)))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        toolBar.setItems([flexSpace,done], animated: true)
        toolBar.sizeToFit()
        
        taskNameTextField.inputAccessoryView = toolBar
        notesTextView.inputAccessoryView = toolBar
        dueDateTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    func updateViews() {
        if let task = tasks {
            taskNameTextField.text = task.name
            dueDateTextField.text = task.due?.stringValue()
            notesTextView.text = task.notes
        }
    }
    
}

extension TaskDetailTableViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
       setupTextFields()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        setupTextFields()
    }
}
