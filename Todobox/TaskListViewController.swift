//
//  TaskListViewController.swift
//  Todobox
//
//  Created by Wonkyoung on 2016. 12. 18..
//  Copyright © 2016년 Wonkyoung. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var editButton: UIBarButtonItem!
    
    var doneButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                      target: nil, action: #selector(doneButtonDidTap))
    
    var tasks: [Task] = [] {
        didSet {
            self.saveAll()
            
            if self.tasks.isEmpty {
                self.doneButtonDidTap()
                self.editButton.isEnabled = false
            } else {
                self.editButton.isEnabled = true
            }
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doneButton.target = self
        self.loadAll()
        self.tableView.reloadData()
    }
    
    func saveAll() {
        let dicts = self.tasks.map { task -> [String: Any] in
            if let memo = task.memo {
                return [
                    "title": task.title,
                    "memo": memo,
                    "done": task.done,
                ]
            }
            return [
                "title": task.title,
                "done": task.done,
            ]
        }
        UserDefaults.standard.set(dicts, forKey: "tasks")
        UserDefaults.standard.synchronize()
    }
    
    func loadAll() {
        guard let dicts = UserDefaults.standard.array(forKey: "tasks") as? [[String: Any]] else { return }
        
        self.tasks = dicts.flatMap { dict -> Task? in
            return Task(dictionary: dict)
        }
        
        self.tableView.reloadData()
    }
    
    @IBAction func editButtonDidTab() {
        self.navigationItem.leftBarButtonItem = self.doneButton
        self.tableView.setEditing(true, animated: true)
    }
    
    func doneButtonDidTap() {
        self.navigationItem.leftBarButtonItem = self.editButton
        self.tableView.setEditing(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let navigationController = segue.destination as? UINavigationController,
            let taskEditViewController =  navigationController.viewControllers.first as? TaskEditViewController {
            taskEditViewController.didAddTask = { newTask in
                self.tasks.append(newTask)
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        cell.detailTextLabel?.text = task.memo
        if task.done {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var task = tasks[indexPath.row]
        task.done = !task.done
        tasks[indexPath.row] = task
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.tasks.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        var temp = self.tasks
        temp.insert(temp.remove(at: sourceIndexPath.row), at: destinationIndexPath.row)
        self.tasks = temp
    }
}

