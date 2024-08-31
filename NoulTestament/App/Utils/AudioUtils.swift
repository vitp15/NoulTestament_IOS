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
            self.player = try AVAudioPlayer(contentsOf: url)
            self.totalTime = player?.duration ?? 0.0
            player?.prepareToPlay()
        } catch {
            print("Error loading audio: \(error)")
        }
        return true
    }
    
    func play() {
        if let player = self.player {
            player.play()
            self.isPlaying = true
        }
    }
    
    func pause() {
        if let player = self.player {
            player.pause()
            self.isPlaying = false
        }
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
