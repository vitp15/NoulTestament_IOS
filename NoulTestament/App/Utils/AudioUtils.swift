//
//  AudioUtils.swift
//  NoulTestament
//
//  Created by Vadim on 31/08/2024.
//

import SwiftUI
import AVKit

extension AudioView {
    func back() {
        backClicked = true
        player?.stop()
        player = nil
        isNavigationBarHidden = false
        presentationMode.wrappedValue.dismiss()
    }
    
    func setupAudio() -> Bool {
        currentTime = loadCurrentTime(book: book, currentChapter: currChapter)
        removeCurrentTime(book: book, currentChapter: currChapter)
        guard let url = Bundle.main.url(forResource: book.getAudioName(chapter: currChapter), withExtension: "mp3")
        else {
            print("Error getting audio url")
            return false
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = delegate
            totalTime = player?.duration ?? 0.0
            player?.prepareToPlay()
            seekAudio(to: currentTime)
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
        if currentTime + time > totalTime && aviableAudio {
            pause()
            next()
        }
    }
    
    func replay(time: TimeInterval) {
        player?.currentTime = (currentTime - time >= 0) ? currentTime - time : 0
    }
    
    func previous() {
        if (currChapter > 1) {
            self.currChapter -= 1
        } else {
            if book.order > 1 {
                book = Storage.instance.books[book.order - 2]
                currChapter = book.chapters
            } else {
                return
            }
        }
        refresh()
    }
    
    func next() {
        if (currChapter < book.chapters) {
            self.currChapter += 1
        } else {
            if book.order < Storage.instance.books.count {
                book = Storage.instance.books[book.order]
                currChapter = 1
            } else {
                return
            }
        }
        refresh()
    }
    
    private func refresh() {
        player?.stop()
        player = nil
        width = 0
        currentTime = 0.0
        totalTime = 0.0
        aviableAudio = setupAudio()
        if aviableAudio {
            play()
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
        if time >= totalTime && aviableAudio {
            pause()
            player?.currentTime = totalTime
            next()
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    class AVdelegate: NSObject, AVAudioPlayerDelegate {
        func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            NotificationCenter.default.post(name: NSNotification.Name("audioFinished"), object: nil)
        }
    }
}
