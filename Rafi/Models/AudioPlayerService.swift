//
//  AudioPlayerService.swift
//  Rafi
//
//  Created by Noor Alhassani on 24/06/1447 AH.
//

import Foundation
import AVFoundation
import Combine

public final class AudioPlayerService: NSObject, ObservableObject {
    @Published public private(set) var currentlyPlayingFileName: String? = nil
    private var player: AVAudioPlayer?

    public override init() {
        super.init()
    }

    public func togglePlay(fileName: String) {
        if currentlyPlayingFileName == fileName {
            stop()
            return
        }
        play(fileName: fileName)
    }

    public func play(fileName: String) {
        stop()
        let url = AudioRecorderService.fileURL(fileName: fileName)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
            currentlyPlayingFileName = fileName
        } catch {
            currentlyPlayingFileName = nil
        }
    }

    public func stop() {
        player?.stop()
        player = nil
        currentlyPlayingFileName = nil
    }
}
