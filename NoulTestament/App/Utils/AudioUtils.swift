//
//  AudioUtils.swift
//  NoulTestament
//
//  Created by Vadim on 31/08/2024.
//

import SwiftUI
import AVKit

extension AudioView {
    func setupAudio() -> Bool {
        guard let url = Bundle.main.url(forResource: book.getAudioName(chapter: currChapter), withExtension: "mp3")
        else {
            print("Error getting audio url")
            return false
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            totalTime = player?.duration ?? 0.0
            player?.prepareToPlay()
        } catch {
            print("Error loading audio: \(error)")
        }
        return true
    }
    
    func play() {
        if let player = self.player {
            player.play()
            isPlaying = true
        }
    }
    
    func pause() {
        if let player = self.player {
            player.pause()
            isPlaying = false
        }
    }
    
    func forward(time: TimeInterval) {
        player?.currentTime = (currentTime + time <= totalTime) ? currentTime + time : totalTime
        if currentTime + time > totalTime {
            pause()
        }
    }

    func replay(time: TimeInterval) {
        player?.currentTime = (currentTime - time >= 0) ? currentTime - time : 0
    }
    
    func updateProgress() {
        guard let player = self.player else {return}
        currentTime = player.currentTime
        if !isDragged {
            width = CGFloat(currentTime / totalTime) * maxWidth
        }
    }
    
    func seekAudio(to time: TimeInterval) {
        player?.currentTime = time
        if time >= totalTime {
            pause()
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
