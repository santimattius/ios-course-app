//
//  Course.swift
//  ios-course-app
//
//  Created by Santiago Mattiauda on 20/11/21.
//

import Foundation

struct Course: Identifiable {
    var id = UUID()
    var name: String
    var description:String
    var image: String
    var favorite: Bool = false
    var free: Bool = false
    var completed:Bool = false
    var level:LevelType = .beginner
}
