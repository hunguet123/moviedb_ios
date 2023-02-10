//
//  Observable.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 19/01/2023.
//

import Foundation

class Observable<T> {
    private var listener: ((T?) -> Void)?
    
    var value: T? {
        willSet {
//            let queue = DispatchQueue(label: "myqueueio", qos: .)
//            queue.async {
//                self.listener?(self.value)
//            }
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init( _ value: T?) {
        self.value = value
    }
    
    func bind( _ listener: @escaping ((T?) -> Void)) {
        listener(value)
        self.listener = listener
    }
}
