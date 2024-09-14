//
//  SimplePlayAudio_macOSApp.swift
//  SimplePlayAudio-macOS
//
//  Created by Speech Tiles LLC on 9/6/24.
//

import SwiftUI

@main
struct SimplePlayAudio_macOSApp: App {
    
    @StateObject var appVF:AppVoiceFlow = AppVoiceFlow()
    
    var body: some Scene {
        WindowGroup {
            PlayAudioView()
                .environmentObject(appVF)
        }
    }
}
