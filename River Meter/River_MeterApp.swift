//
//  River_MeterApp.swift
//  River Meter
//
//  Created by Ognjen Tomic on 11.12.20..
//

import SwiftUI

@main
struct River_MeterApp: App {
    
    @State private var rivers = River.riverPreviewListData

    var body: some Scene {
        WindowGroup {
            RiverPicker(rivers: rivers)
        }
    }
}
