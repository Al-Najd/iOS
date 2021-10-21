//
//  MusicService.swift
//  The One (iOS)
//
//  Created by Ahmed Ramy on 21/10/2021.
//

import AVFoundation

class MusicService {
  static let main = MusicService()
  var player: AVAudioPlayer?
  
  func start(track: Track, repeats: Bool = false) {
    do {
      player = try AVAudioPlayer(contentsOf: track.fileURL)
      guard let player = player else { return }
      player.prepareToPlay()
      player.currentTime = 1
//      player.play()
    } catch {
      assertionFailure(error.localizedDescription)
    }
  }
  
  func stop() {
    player?.stop()
  }
}

extension MusicService {
  enum Track {
    case splash
    
    var fileURL: URL {
      switch self {
      case .splash:
        return URL(fileURLWithPath: Bundle.main.path(forResource: "splash", ofType: "mp3") ?? .empty)
      }
    }
  }
}
