//
//  AudioManager.swift
//  MagicMusic
//
//  Created by Chandler on 2020/2/9.
//  Copyright © 2020 Chandler. All rights reserved.
//

import Foundation
import StreamingKit

enum PlayerState {
    case playing
    case pausing
    case stoping
}

class AudioManager {
    private static let audioRoot = "http://www.kokole.top/music/audio/"
    private static let audioPlayer = STKAudioPlayer()
    private static var playerState = PlayerState.stoping
    private static func changeState(to state: PlayerState) {
        self.playerState = state
        print("当前播放器状态为\(self.playerState)")
    }
    private static var playingMusicId = "-1"
}

extension AudioManager {
    
    public class func play(music: Music) {
        if self.playingMusicId == music.mid {
            audioPlayer.resume()
        }else{
            let webUrl = music.audioUrl
            audioPlayer.play(webUrl)
            self.playingMusicId = music.mid
        }
    }
    
    public class func pause() {
        audioPlayer.pause()
    }
}
