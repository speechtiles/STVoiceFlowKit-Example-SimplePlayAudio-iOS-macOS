# STVoiceFlowKit-Example-SimplePlayAudio-iOS-macOS
 ==========================================================================
 
Example project performs simple audio playback using [STVoiceFlowKit SDK](https://speechtiles.com/developer) and sample configured [JSON Voiceflows](https://speechtiles.com/developerdoc/BZVoiceFlowDoc/macOS-iOS/api/html/index.php) - iOS and macOS.

The project contains a code example that illustrate how to set up and customize audio playback of recorded audio files. Multiple configuration sample examples are provided that demonstate the ability of changing and customizing audio playback without the need to change code. You can run the SimplePlayAudio app on iOS and macOS.

## Using BZVoiceFlow interface

This project contains a sample code for:

* [BZVoiceFlow](https://speechtiles.com/developerdoc/BZVoiceFlowDoc/macOS-iOS/api/html/index.php),  [BZVoiceFlowController](https://speechtiles.com/developerdoc/BZVoiceFlowDoc/macOS-iOS/api/html/Classes/BZVoiceFlowController.php) and [BZVoiceFlowCallback](https://speechtiles.com/developerdoc/BZVoiceFlowDoc/macOS-iOS/api/html/Protocols/BZVoiceFlowCallback.php).

## Configuring VoiceFlows in JSON

This project also contains multiple sample Voiceflow JSON configurations for audio playback of recorded audio files:

* **VF_PlayRecordedAudio_Example-1.json**: Audio playback of an introduction (P_Intro-Single.wav) followed by the audio playback of a wave file (P_Wave-Audio.wav)
* **VF_PlayRecordedAudio_Example-2.json**: Audio playback of an introduction (P_Intro-Multiple.wav) followed by the audio playback of multiple audio files with differnet formats using multiple Voice Flow modules, each referencing a single recorded audio file (P_Wave-Audio.wav, P_M4A-Audio.m4a, P_MP3-Audio.mp3 and P_PCM-Audio.pcm).
* **VF_PlayRecordedAudio_Example-3.json**: Audio playback of an introduction (P_Intro-Multiple-OneVFM.wav) followed by the audio playback of multiple audio files with differnet formats using a single Voice Flow module referencong a single Audio Prompt module which is in turn configured to reference multiple recorded audio files (P_Wave-Audio.wav, P_M4A-Audio.m4a, P_MP3-Audio.mp3 and P_PCM-Audio.pcm).

## Requirements

* The latest [XCode](https://developer.apple.com/xcode)
* The package [STVoiceFlowKit-SP](https://github.com/speechtiles/STVoiceFlowKit-SP)


## Getting Started

* Click on the green “Code” button and select the “Open with Xcode” option.
* Follow the steps in Xcode to clone and open the project.
* Build and run.

To switch among the JSON Voice Flows:
*Open the file **PlayAudioFlow.swift** and comment/uncomment the lines as in this example:
    let voiceFlowURL = "VF_PlayRecordedAudio_Example-1.json"
    //let voiceFlowURL = "VF_PlayRecordedAudio_Example-2.json"
    //let voiceFlowURL = "VF_PlayRecordedAudio_Example-3.json"
    
* Build and run

## License

This software is licensed under a [modified BSD license](https://github.com/speechtiles/STVoiceFlowKit-Example-SimplePlayAudio-iOS-macOS/blob/main/LICENSE).

## Additional Resources

* [SpeechTiles Developer](https://www.speechTiles.com/developer)
* [STVoiceFlow Kit API reference](https://speechtiles.com/developerdoc/BZVoiceFlowDoc/macOS-iOS/api/html/index.php)
* [Speech Tiles Developer support](https://speechtiles.com/developer/support.php)

Thanks,
The Speech Tiles Team

