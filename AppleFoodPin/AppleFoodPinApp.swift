//
//  AppleFoodPinApp.swift
//  AppleFoodPin
//
//  Created by user on 2022/12/21.
//

import SwiftUI

@main
struct AppleFoodPinApp: App {
    
    let persistenceController = PersistenceController.shared
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 22, green: 220, blue: 57), .font: UIFont(name: "ArialRoundedMTBold", size: 35)!]
        
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle"), .font: UIFont(name: "ArialRoundedMTBold", size: 35)!]
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemRed, .font: UIFont(name: "ArialRoundedMTBold", size: 20)!]
        
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.backgroundEffect = .none
        navBarAppearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
