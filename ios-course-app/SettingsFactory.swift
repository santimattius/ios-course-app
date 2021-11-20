//
//  SettingsFactory.swift
//  ios-course-app
//
//  Created by Santiago Mattiauda on 20/11/21.
//

import Foundation


import Foundation
import Combine

final class SettingsFactory: ObservableObject{
    
    @Published var defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        
        defaults.register(defaults: [
            "app.view.settings.order": 0,
            "app.view.settings.showCompleted": false,
            "app.view.settings.showFree": false,
            "app.view.settings.showFavorite": false,
        ])
    }
    
    
    var order: SortingOrderType{
        get{
            SortingOrderType(type: defaults.integer(forKey: "app.view.settings.order"))
        }
        set{
            defaults.set(newValue.rawValue, forKey: "app.view.settings.order")
        }
    }
    
    var showCompletedOnly: Bool{
        get{
            defaults.bool(forKey: "app.view.settings.showCompleted")
        }
        set{
            defaults.set(newValue, forKey: "app.view.settings.showCompleted")
        }
    }
    
    var showFreeOnly: Bool{
        get{
            defaults.bool(forKey: "app.view.settings.showFree")
        }
        set{
            defaults.set(newValue, forKey: "app.view.settings.showFree")
        }
    }
    
    var showFavoriteOnly: Bool{
        get{
            defaults.bool(forKey: "app.view.settings.showFavorite")
        }
        set{
            defaults.set(newValue, forKey: "app.view.settings.showFavorite")
        }
    }
    
}
