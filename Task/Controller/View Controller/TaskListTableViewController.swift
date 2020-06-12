//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Victor Monteiro on 6/11/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController {
    
    var task = [Task]()
    var incompleteTaskas: [Task] = []
    var completedTasks: [Task] = []
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.fetchResultController.delegate = self
    }
    @IBAction func segmentControlTapped(_ sender: UISegmentedControl){
       
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
         
        
        return TaskController.shared.fetchResultController.sections?.count  ?? 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
         guard let sections = TaskController.shared.fetchResultController.sections else {
                   fatalError("No sections in fetchedResultsController")
               }
               let sectionInfo = sections[section]
               return sectionInfo.numberOfObjects
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell else { return UITableViewCell()}
        
        let task = TaskController.shared.fetchResultController.object(at: indexPath)
        cell.delegate = self
        cell.update(withTask: task)
        
        return cell
    }
    
   override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

    let sectionInfo = TaskController.shared.fetchResultController.sections![section]
    var sectionName = sectionInfo.name
    
    if sectionName == "1" {
        sectionName = "Complete"
    } else {
        sectionName = "Not Complete"
    }
    return sectionName
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let task = TaskController.shared.fetchResultController.object(at: indexPath)
            TaskController.shared.remove(task: task)
        }
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? TaskDetailTableViewController
                else { return }
            
            let task = TaskController.shared.fetchResultController.object(at: indexPath)
            destinationVC.tasks = task
        }
    }
}

extension TaskListTableViewController: ButtonTableViewCellDelegate, NSFetchedResultsControllerDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let task = TaskController.shared.fetchResultController.object(at: indexPath)
         TaskController.shared.buttonIsToggled(task: task)
        sender.update(withTask: task)
       
    }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .fade)
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .fade)
        @unknown default:
            fatalError()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
       
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        @unknown default:
           fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
}
