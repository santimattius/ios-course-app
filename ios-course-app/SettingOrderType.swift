//
//  SettingOrderType.swift
//  ios-course-app
//
//  Created by Santiago Mattiauda on 20/11/21.
//

import Foundation

enum SortingOrderType: Int, CaseIterable {
    
    case alphabetical = 0
    case completed = 1
    case free = 2
    case favorite = 3
    
    init(type: Int) {
        switch type {
        case 0:
            self = .alphabetical
        case 1:
            self = .completed
        case 2:
            self = .free
        case 3:
            self = .favorite
        default:
            self = .alphabetical
        }
    }
    
    var description : String {
        switch self {
        case .alphabetical:
            return "Alphabetically"
        case .completed:
            return "Completed"
        case .free:
            return "Free"
        case .favorite:
            return "Favorite"
        }
    }
    
    
    func predicateSort() -> ((Course, Course) -> Bool){
        switch self {
        case .alphabetical:
            return {$0.name < $1.name}
        case .completed:
            return {$0.completed && !$1.completed}
        case .free:
            return {$0.free && !$1.free}
        case .favorite:
            return {$0.favorite && !$1.favorite}
        }
    }
    
}
