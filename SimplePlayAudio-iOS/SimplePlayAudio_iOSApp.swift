//
//  SimplePlayAudio_iOSApp.swift
//  SimplePlayAudio-iOS
//
//  Created by Speech Tiles LLC on 9/6/24.
//

import SwiftUI

@main
struct SimplePlayAudio_iOSApp: App {
    
    @StateObject var appVF:AppVoiceFlow = AppVoiceFlow()
    
    var body: some Scene {
        WindowGroup {
            PlayAudioView()
                .environmentObject(appVF)
        }
    }
}
