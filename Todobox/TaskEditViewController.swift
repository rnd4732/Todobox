//
//  TaskEditViewController.swift
//  Todobox
//
//  Created by Wonkyoung on 2016. 12. 19..
//  Copyright © 2016년 Wonkyoung. All rights reserved.
//

import UIKit

class TaskEditViewController: UIViewController {
    
    @IBOutlet var titleInput: UITextField!
    @IBOutlet var memoInput: UITextView!
    
    var didAddTask: ((Task) -> Void)?
    
    @IBAction func cancelButtonDipTab() {
        
        guard let title = titleInput.text else { return }
        
        if !title.trimmingCharacters(in: .whitespaces).isEmpty {
            
            let alertController = UIAlertController(title: "호곡!", message: "ㄹㅇ 취소할거?", preferredStyle: .alert)
        
            let yes = UIAlertAction(title: "삭제하고 나가기", style: .destructive) { _ in
                self.dismiss(animated: true, completion: nil)
            }
        
            let no = UIAlertAction(title: "나가지 않기", style: .default, handler: nil)
        
            alertController.addAction(no)
            alertController.addAction(yes)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func doneButtonDipTab() {
        
        guard let title = titleInput.text,
            let memo = memoInput.text,
            !title.trimmingCharacters(in: .whitespaces).isEmpty
            else {
                shake(self.titleInput)
                return
        }
        
        let newTask = Task(title: title, memo: memo)
        
        self.didAddTask?(newTask)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func shake(_ view: UIView) {
        UIView.animate(
            withDuration: 0.05,
            animations: { view.frame.origin.x -= 5 },
            completion: { _ in
                UIView.animate(
                    withDuration: 0.05,
                    animations: { view.frame.origin.x += 10 },
                    completion: { _ in
                        UIView.animate(
                            withDuration: 0.05,
                            animations: { view.frame.origin.x -= 10 },
                            completion: { _ in
                                UIView.animate(
                                    withDuration: 0.05,
                                    animations: { view.frame.origin.x += 10 },
                                    completion: { _ in
                                        UIView.animate(
                                            withDuration: 0.05,
                                            animations: { view.frame.origin.x -= 5 },
                                            completion: { _ in
                                                view.becomeFirstResponder()
                                        })
                                }
                                )
                        }
                        )
                }
                )
        }
        )
    }
    
}
