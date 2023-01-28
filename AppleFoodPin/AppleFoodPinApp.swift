//
//  AppleFoodPinApp.swift
//  AppleFoodPin
//
//  Created by user on 2022/12/21.
//

import SwiftUI

@main
struct AppleFoodPinApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
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
    
    
    func createQuickActions() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            let shortcutItem1 = UIApplicationShortcutItem(type: "\(bundleIdentifier).OpenFavorites", localizedTitle: "Show Favorites", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(systemImageName: "tag"), userInfo: nil)
            let shortcutItem2 = UIApplicationShortcutItem(type: "\(bundleIdentifier).OpenDiscover", localizedTitle: "Discover Restaurants", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(systemImageName: "eyes"), userInfo: nil)
            let shortcutItem3 = UIApplicationShortcutItem(type: "\(bundleIdentifier).NewRestaurant", localizedTitle: "New Restaurant", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .add), userInfo: nil)
            UIApplication.shared.shortcutItems = [shortcutItem1, shortcutItem2, shortcutItem3]
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { (phase) in
            switch phase {
            case .active:
                print("active")
            case .inactive:
                print("inactive")
            case .background:
                createQuickActions()
            @unknown default:
                print("default scene phase")
            }
            
        }
    }
}
