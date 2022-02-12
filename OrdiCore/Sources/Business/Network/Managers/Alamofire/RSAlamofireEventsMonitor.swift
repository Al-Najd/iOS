//
//  RSAlamofireEventsMonitor.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/11/2021.
//

import Alamofire
import Foundation
import Entity
import Logging
import OrdiLogging
import Pulse

public struct RSAlamofireEventsMonitor: EventMonitor {
    let logger: NetworkLogger

    public func request(_: Request, didCreateTask task: URLSessionTask) {
        logger.logTaskCreated(task)
    }

    public func urlSession(_: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        logger.logDataTask(dataTask, didReceive: data)
    }

    public func urlSession(_: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        logger.logTask(task, didFinishCollecting: metrics)
    }

    public func urlSession(_: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        logger.logTask(task, didCompleteWithError: error)
    }
}
