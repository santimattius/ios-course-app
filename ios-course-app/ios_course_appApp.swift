//
//  ios_course_appApp.swift
//  ios-course-app
//
//  Created by Santiago Mattiauda on 20/11/21.
//

import SwiftUI

@main
struct ios_course_appApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(SettingsFactory())
        }
    }
}
