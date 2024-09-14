//
//  PlayAudioView.swift
//  SimplePlayAudio
//
//  Created by Speech Tiles LLC on 9/6/24.
//

import SwiftUI

struct PlayAudioView: View {
    @EnvironmentObject var appVF: AppVoiceFlow
    
    var body: some View {
        VStack(spacing: 20) {
             Text("Simple Play Audio")
               .font(.largeTitle)
             Text("(BZVoiceFlow Framework)")
               .font(.title)
               .foregroundColor(.gray)
                  
            
            Button(action: {
                !appVF.voiceFlowActive ? appVF.Execute() : appVF.Stop()
            }) {
                Text(!appVF.voiceFlowActive ? "Start Play Audio Voiceflow" : "Stop Play Audio Voiceflow")
                      .padding()
                      .foregroundColor(.white)
                      .background( !appVF.voiceFlowActive ? .green : .red)
                      .cornerRadius(10)
                  }
            
            
        }
        .onAppear() {
            appVF.LoadVoiceflowData()
        }
    }
}

#Preview {
    PlayAudioView()
        .environmentObject(AppVoiceFlow())
}
