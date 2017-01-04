//
//  Task.swift
//  Todobox
//
//  Created by Wonkyoung on 2016. 12. 19..
//  Copyright © 2016년 Wonkyoung. All rights reserved.
//

struct Task {
    var title: String
    var memo: String?
    var done: Bool
    
    init(title: String, memo: String? = nil) {
        self.title = title
        self.memo = memo
        self.done = false
    }
    
    
    // ? = nil을 반환할 수 있는 생성자
    init?(dictionary: [String: Any]) {
        
        if
            let title = dictionary["title"] as? String,
            let done = dictionary["done"] as? Bool {
            
            self.title = title
            self.memo = dictionary["memo"] as? String
            self.done = done
        } else {
            return nil
        }
    }
}
