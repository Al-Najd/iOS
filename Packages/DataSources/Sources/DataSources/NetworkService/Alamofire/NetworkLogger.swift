//
//  NetworkLogger.swift
//  CAFU
//
//  Created by Ahmed Ramy on 13/09/2022.
//

import Alamofire
import Foundation
import Loggers

// MARK: - NetworkLogger

// swiftlint:disable line_length
struct NetworkLogger: EventMonitor {
    func request(_ request: Request, didCreateTask task: URLSessionTask) {
        Log.networkTaskCreated(request, task)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        Log.networkDidReceive(data: data, for: dataTask, in: session)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        Log.networkFinishedCollecting(metrics: metrics, for: task, in: session)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        Log.networkTaskFailed(withError: error, for: task, in: session)
    }
}

// MARK: - Network
public extension LoggersService {
    static func networkTaskCreated(_ request: Request, _ task: URLSessionTask) {
        PulseLogger.main.request(request, didCreateTask: task)
        let url = request.request?.url?.absoluteString ?? ""
        let method = request.request?.httpMethod ?? ""
        SystemLogger.main.networkTaskCreated(url: "[\(method)] \(url)", task)
    }

    static func networkDidReceive(data: Data, for task: URLSessionDataTask, in session: URLSession) {
        PulseLogger.main.urlSession(session, dataTask: task, didReceive: data)
        SystemLogger.main.networkDidReceive(data: data, for: task, in: session)
    }

    static func networkFinishedCollecting(metrics: URLSessionTaskMetrics, for task: URLSessionTask, in session: URLSession) {
        PulseLogger.main.urlSession(session, task: task, didFinishCollecting: metrics)
    }

    static func networkTaskFailed(withError error: Error?, for task: URLSessionTask, in session: URLSession) {
        PulseLogger.main.urlSession(session, task: task, didCompleteWithError: error)
        SystemLogger.main.networkTaskFailed(withError: error, for: task, in: session)
    }

    static func networkDecodingFailed(for task: URLSessionTask, with decodingError: DecodingError?, for type: Decodable.Type) {
        PulseLogger.main.logTask(task: task, didFinishDecodingWithError: decodingError)
        SystemLogger.main.networkDecodingFailed(for: task, with: decodingError, for: type)
    }
}

public extension PulseLogger {
    func request(_: Request, didCreateTask task: URLSessionTask) {
        networkLogger.logTaskCreated(task)
    }

    func urlSession(_: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        networkLogger.logDataTask(dataTask, didReceive: data)
    }

    func urlSession(_: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        networkLogger.logTask(task, didFinishCollecting: metrics)
    }

    func urlSession(_: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        networkLogger.logTask(task, didCompleteWithError: error)
    }

    func logTask(task: URLSessionTask, didFinishDecodingWithError decodingError: DecodingError?) {
        networkLogger.logTask(task, didFinishDecodingWithError: decodingError)
    }
}
