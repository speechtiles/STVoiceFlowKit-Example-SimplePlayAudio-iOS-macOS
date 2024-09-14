//
//  AppVoiceFlow.swift
//  SimplePlayAudio
//
//  Created by Speech Tiles LLC on 9/6/24.
//

import Foundation

import BZVoiceFlow
import BZMedia

public final class AppVoiceFlow: NSObject, ObservableObject, BZVoiceFlowCallback {
    
    @Published var voiceFlowActive: Bool = false
    @Published var playing: Bool = false
    
    let voiceFlowURL = "VF_PlayRecordedAudio_Example-1.json"
    //let voiceFlowURL = "VF_PlayRecordedAudio_Example-2.json"
    //let voiceFlowURL = "VF_PlayRecordedAudio_Example-3.json"

    var m_bzVoiceFlowController: BZVoiceFlowController? = nil
    
    public override init() {
        super.init()

            InitializeBZVoiceFlowController()
            if !m_bzVoiceFlowController!.setVoiceFlowCallback(voiceFlowCallback: self) {
                print("❌ VoiceFlow: setVoiceFlowCallback failed .")
            }
    }
    
    func LoadVoiceflowData() {
        
        // Load Audio Prompt file
        var bzResult:BZ_RESULT = m_bzVoiceFlowController!.loadAudioPromptModules(localFileURL: "P_PlayAudio.json")
        if bzResult != .BZ_SUCCESS {
            print("❌ LoadVoiceflowData: Failed to load Audio Prompt File \"P_PlayAudio.json\". Error = \"\(m_bzVoiceFlowController!.forBZResult(bzResult: bzResult))\"")
            return
        }
        
        // Load Voiceflow file
        bzResult = m_bzVoiceFlowController!.loadVoiceflow(localFileURL: voiceFlowURL)
        if bzResult != .BZ_SUCCESS {
            print("❌ LoadVoiceflowData: Failed to load Voiceflow File \"\(voiceFlowURL)\". Error = \"\(m_bzVoiceFlowController!.forBZResult(bzResult: bzResult))\"")
            return
        }
        
        print("✅ LoadVoiceflowData: Voiceflow data loaded successfully.")
    }
    
    func Execute() {
        let bzResult:BZ_RESULT = m_bzVoiceFlowController!.runVoiceflow()
        if bzResult != .BZ_SUCCESS {
            print("❌ Execute: Failed to execute VoiceFlow \"\(voiceFlowURL)\". Error = \"\(m_bzVoiceFlowController!.forBZResult(bzResult: bzResult))\"")
            return
        }
        print("✅ Execute: Started Voiceflow \"\(voiceFlowURL)\" execution successfully.")
    }
    
    func Stop() {
        let bzResult:BZ_RESULT = m_bzVoiceFlowController!.stopVoiceflow()
        if bzResult != .BZ_SUCCESS {
            print("❌ Execute: Failed to stop VoiceFlow \"\(voiceFlowURL)\" Execution. Error = \"\(m_bzVoiceFlowController!.forBZResult(bzResult: bzResult))\"")
            return
        }
        print("✅ Execute: Started to stop Voiceflow \"\(voiceFlowURL)\" execution successfully.")
    }
    
    
    func InitializeBZVoiceFlowController () {
        
        if m_bzVoiceFlowController == nil {
            m_bzVoiceFlowController = BZVoiceFlowController()
            
            // Setting log levels for BZVoiceFlow framework
            m_bzVoiceFlowController!.setLogLevel(logLevel: "none")
            
            // Setting log levels for media modules in BZMedia Framework
            m_bzVoiceFlowController!.setMediaModulesLogLevels(logLevels: loadMediaModulesLogLevel())
            
            // Initializing VoiceFlow controller
            var bzResult:BZ_RESULT = m_bzVoiceFlowController!.initialize()
            if bzResult != .BZ_SUCCESS {
                print("❌ InitializeBZVoiceFlowController: Initializing VoiceFlow Controller failed. Error = \"\(m_bzVoiceFlowController!.forBZResult(bzResult: bzResult))\"")
                return
            }

#if os(iOS)
            // Initiliazing audio session for iOS only application with default parameters
            bzResult = m_bzVoiceFlowController!.initializeDefaultAudioSession()
            if bzResult != .BZ_SUCCESS {
                print("❌ InitializeBZVoiceFlowController: Initializing default audio session failed. Error = \"\(m_bzVoiceFlowController!.forBZResult(bzResult: bzResult))\"")
                return
            }
#endif

            // Initializing media modules required for running this application
            bzResult = m_bzVoiceFlowController!.initializeDefaultMediaModules()
            if bzResult != .BZ_SUCCESS {
                print("❌ InitializeBZVoiceFlowController: Initializing default media modules failed. Error = \"\(m_bzVoiceFlowController!.forBZResult(bzResult: bzResult))\"")
                return
            }
            
            // Setting the location of the audio files used for audio playback
            guard let path = Bundle.main.path(forResource: "Data/Audio", ofType: "") else {
                print("❌ InitializeBZVoiceFlowController: Failed to find Media Source Location at \"Data/Audio\". Reason: Path not found ")
                return
            }
            bzResult = m_bzVoiceFlowController!.setMediaResourceLocation(fileCategory: .FC_PLAY_AUDIO, localURL: path)
            if bzResult != .BZ_SUCCESS {
                print("❌ InitializeBZVoiceFlowController: Setting media source location to \"\(path)\" failed. Error = \"\(m_bzVoiceFlowController!.forBZResult(bzResult: bzResult))\"")
                return
            }
            else {
                print("✅ InitializeBZVoiceFlowController: Media Source Location set to \"\(path)\"")
            }
            
            // Setting the location of the VoiceFlow source files used for running the voice flow
            guard let path = Bundle.main.path(forResource: "Data/Voiceflows", ofType: "") else {
                print("❌ InitializeBZVoiceFlowController: Failed to find Voiceflow Source Location at \"Data/Voiceflows\". Reason: Path not found ")
                return
            }
            bzResult = m_bzVoiceFlowController!.setMediaResourceLocation(fileCategory: .FC_VOICEFLOW, localURL: path)
            if bzResult != .BZ_SUCCESS {
                print("❌ InitializeBZVoiceFlowController: Setting Voiceflow source location to \"\(path)\" failed. Error = \"\(m_bzVoiceFlowController!.forBZResult(bzResult: bzResult))\"")
                return
            }
            else {
                print("✅ InitializeBZVoiceFlowController: Voiceflow source Location set to \"\(path)\"")
            }
        }
    }
    
    private func loadMediaModulesLogLevel() -> [String:String?]
    {
        // For Log level options look at documentation at:
        // https://speechtiles.com/developerdoc/BZVoiceFlowDoc/macOS-iOS/api/html/Classes/BZVoiceFlowController.php#//api/name/setMediaModulesLogLevels
        
        let logLevels:[String:String?] = [
            "MediaController":"none",
            "MediaEngine":"none",
            "MediaEngineWrapper":"none",
            "MediaPermissions":"none",
            "AudioStreamer":"none",
            "AudioFileRecorder":"none",
            "AudioSession":"none",
            "AudioPlayer":"none",
            "AudioRecorder":"none",
            "FliteSS":"none",
            "AppleSS":"none",
            "PocketSphinxSR":"none",
            "AppleSR":"none",
        ]
        
        return logLevels
    }
    
    
// Methods for BZVoiceFlowCallback protocol
    public func BZVFC_PreModuleStart(vfModuleID: String) {
        if vfModuleID == "VF_START" {
            voiceFlowActive = true
            print("BZVFC_PreModuleStart: Voiceflow \"\(voiceFlowURL)\" started execution.")
        }
    }
    
    public func BZVFC_PreModuleEnd(vfModuleID: String) {
        
        if vfModuleID == "VF_END" {
            voiceFlowActive = false
            print("BZVFC_PreModuleEnd: Voiceflow \"\(voiceFlowURL)\" finished execution.")
        }
    }
    
    public func BZVFC_SRHypothesis(vfModuleID: String, srData: BZVoiceFlow.BZSRData) {
        
    }
    
    public func BZVFC_MediaEvent(vfModuleID: String, mediaItemID: String, mediaFunction: BZNotifyMediaFunction, mediaEvent: BZNotifyMediaEvent, mediaEventData: [AnyHashable : Any]) {
        
        if mediaFunction == .NMF_PLAY_AUDIO {
            if mediaEvent == .NME_STARTED {
                playing = true
                print("BZVFC_MediaEvent: Started audio playback of \"\(mediaItemID)\" in Voiceflow module \"\(vfModuleID)\"")
            } else if mediaEvent == .NME_ENDED || mediaEvent == .NME_STOPPED {
                playing = false
                print("BZVFC_MediaEvent: Finished audio playback of \"\(mediaItemID)\" in Voiceflow module \"\(vfModuleID)\"")
            }
        }
    }
    
    public func BZVFC_PlayAudioSegmentData(vfModuleID: String, promptID: String, audioSegmentType: BZAudioSegmentType, audioFile: String?, textString: String?, textFile: String?) {
        
    }
    
    public func BZVFC_PermissionEvent(permissionEvent: BZNotifyMediaEvent) {
        
    }
    
}
