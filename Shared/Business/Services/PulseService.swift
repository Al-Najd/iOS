//
//  PulseService.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 23/10/2021.
//

import Pulse
import Logging
import Foundation
import Moya
import Alamofire

public final class PulseService {
  public static let main: PulseService = .init()
}

public final class PulseLogger: LogEngine {
  public static let main: PulseLogger = .init()
  
  private let logger = Logger(label: "com.com.nerdor.theone.The-One")
  private init() { }
  
  public func info(message: String) {
    #if DEBUG
    logger.info(Logger.Message(stringLiteral: message))
    #endif
  }
  
  public func warn(message: String) {
    #if DEBUG
    logger.warning(Logger.Message(stringLiteral: message))
    #endif
  }
  
  public func error(message: String) {
    #if DEBUG
    logger.error(Logger.Message(stringLiteral: message))
    #endif
  }
}

struct NetworkLoggerEventMonitor: EventMonitor {
    let logger: NetworkLogger
    
    func request(_ request: Request, didCreateTask task: URLSessionTask) {
        logger.logTaskCreated(task)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        logger.logDataTask(dataTask, didReceive: data)
        
        guard let response = dataTask.response else { return }
        logger.logDataTask(dataTask, didReceive: response)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        logger.logTask(task, didFinishCollecting: metrics)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        logger.logTask(task, didCompleteWithError: error)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse) {
        logger.logDataTask(dataTask, didReceive: proposedResponse.response)
    }
}
