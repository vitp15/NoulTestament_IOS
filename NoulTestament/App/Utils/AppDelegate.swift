//
//  AppDelegate.swift
//  NoulTestament
//
//  Created by Vadim on 01/09/2024.
//

import SwiftUI
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    func applicationDidEnterBackground(_ application: UIApplication) {
        // App moved to the background
        print("App moved to background")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // App is about to terminate
        print("App will terminate")
    }

    func applicationDidFinishLaunching(_ application: UIApplication) {
        // App has launched
        print("App did finish launching")
    }
}
