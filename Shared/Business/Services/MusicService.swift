//
//  MusicService.swift
//  The One (iOS)
//
//  Created by Ahmed Ramy on 21/10/2021.
//

import AVFoundation

class MusicService {
  static let main = MusicService()
  private var musicPlayer: AVAudioPlayer?
  private var effectPlayer: AVAudioPlayer?
  
  func start(track: Track, repeats: Bool = false) {
    do {
      musicPlayer = try AVAudioPlayer(contentsOf: track.fileURL)
      guard let player = musicPlayer else { return }
      player.prepareToPlay()
      player.currentTime = 1
      if repeats {
        player.numberOfLoops = -1
      }
      player.play()
    } catch {
      LoggersManager.error(RSErrorParser().parse(error))
      assertionFailure(error.localizedDescription)
    }
  }
  
  func start(effect: Effect) {
    do {
      effectPlayer = try AVAudioPlayer(contentsOf: effect.fileURL)
      guard let player = effectPlayer else { return }
      player.prepareToPlay()
      player.currentTime = 1
      player.play()
    } catch {
      LoggersManager.error(RSErrorParser().parse(error))
      assertionFailure(error.localizedDescription)
    }
  }
  
  func stop() {
    musicPlayer?.stop()
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
  
  enum Effect {
    case splashEnd
    
    var fileURL: URL {
      switch self {
      case .splashEnd:
        return URL(fileURLWithPath: Bundle.main.path(forResource: "splashEnd", ofType: "mp3") ?? .empty)
      }
    }
  }
}
