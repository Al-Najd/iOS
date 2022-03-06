//
//  AlamofireManager.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/11/2021.
//

import Alamofire
import AuthenticationServices
import Combine
import Foundation
import Entity
import OrdiLogging
import Pulse

public final class AlamofireManager: NetworkProtocol {
    public static let main = AlamofireManager()
    public let logger: NetworkLogger = .init()
    public typealias Percentage = Double
    public typealias Publisher = AnyPublisher<Percentage, Error>

    private typealias Subject = CurrentValueSubject<Percentage, Error>
    private var subjectsByTaskID = [UUID: Subject]()
    private lazy var session: Alamofire.Session = .init(eventMonitors: [RSAlamofireEventsMonitor(logger: logger)])

    private var cancellables = Set<AnyCancellable>()

    public func call<T: Codable, U: Endpoint>(api: U, model: T.Type) -> RSResponse<T> {
        let subject = PassthroughSubject<T, OError>()
        session.request(
            api.baseURL + api.path,
            method: api.method.toAlamofireFriendly(),
            parameters: api.parameters,
            encoding: api.encoding.toAlamofireFriendly(),
            headers: api.headers.toAlamofireFriendly()
        ).responseData { response in
            var result: Result<Data, Error>
            if let data = response.data {
                result = .success(data)
            } else if let error = response.error {
                result = .failure(error)
            } else {
                result = .failure(OError.somethingWentWrong)
            }

            switch result {
            case let .success(data):
                let error = OErrorParser().parse(data)
                if error.text != OError.somethingWentWrong.text {
                    subject.send(completion: .failure(error))
                } else if let model = SuccessParser().parse(data, expectedType: model) {
                    subject.send(model)
                } else {
                    subject.send(completion: .failure(.somethingWentWrong))
                }
            case let .failure(error):
                subject.send(completion: .failure(OErrorParser().parse(error)))
            }
        }

        return subject.eraseToAnyPublisher()
    }

    public func upload<T: Codable, U: Endpoint>(api: U, model: T.Type) -> RSResponseWithProgress<T> {
        let subject = PassthroughSubject<RSProgressResponse<T>, OError>()
        let request = session.upload(
            multipartFormData:
            ParametersToMultipartFormDataAdapter()
                .adapt(api.parameters),
            to: api.baseURL + api.path
        ).uploadProgress { progress in
            let totalBytesSent = progress.totalUnitCount
            let totalBytesExpectedToSend = progress.completedUnitCount
            debugPrint(progress)
            subject.send(.loading(Double(totalBytesSent) / Double(totalBytesExpectedToSend)))
        }

        enqueueTaskForProgressObservation(request.id)

        request.responseData { response in
            var result: Result<Data, Error>
            if let data = response.data {
                result = .success(data)
            } else if let error = response.error {
                result = .failure(error)
            } else {
                result = .failure(OError.somethingWentWrong)
            }

            switch result {
            case let .success(data):
                if let model = SuccessParser().parse(data, expectedType: model) {
                    subject.send(.finished(model))
                    subject.send(completion: .finished)
                } else {
                    subject.send(completion: .failure(OErrorParser().parse(data)))
                }
            case let .failure(error):
                subject.send(completion: .failure(OErrorParser().parse(error)))
            }
        }

        subscribe(to: request.id)?
            .sink(receiveCompletion: { [weak self] _ in
                self?.dequeueTaskFromProgressObservation(request.id)
            }, receiveValue: { percentage in
                subject.send(.loading(percentage))
            }).store(in: &cancellables)

        return subject.eraseToAnyPublisher()
    }

    private func enqueueTaskForProgressObservation(_ id: UUID) {
        subjectsByTaskID[id] = .init(0)
    }

    private func dequeueTaskFromProgressObservation(_ id: UUID) {
        subjectsByTaskID.removeValue(forKey: id)
    }

    private func subscribe(to id: UUID) -> Publisher? {
        subjectsByTaskID[id]?.eraseToAnyPublisher()
    }
}

public struct SuccessParser {
    func parse<T: Codable>(_ data: Data, expectedType: T.Type) -> T? {
        data.decode(expectedType)
    }
}

public struct OErrorParser {
    func parse(_ error: Error) -> OError {
        switch error {
        case let urlError as URLError:
            return NetworkErrorToOErrorAdapter().adapt(urlError)
//        case let googleSignInError as GIDSignInError:
//            return GIDSignInErrorToOErrorAdapter().adapt(googleSignInError)
        case let appleSignInError as ASAuthorizationError:
            return ASAuthorizationErrorToOError().adapt(appleSignInError)
//        case let validationError as ValidationError:
//            return .init(validation: validationError)
        default:
            return error as? OError ?? .init(text: error.localizedDescription)
        }
    }

    func parse(_ data: Data) -> OError {
        .somethingWentWrong
    }
}

extension Business.HTTPMethod {
    func toAlamofireFriendly() -> Alamofire.HTTPMethod {
        switch self {
        case .GET:
            return .get
        case .POST:
            return .post
        }
    }
}

extension Business.ParametersEncoding {
    func toAlamofireFriendly() -> Alamofire.ParameterEncoding {
        switch self {
        case .urlEncoding:
            return URLEncoding.default
        case .jsonEncoding:
            return JSONEncoding.default
        case .multipartEncoding:
            return JSONEncoding.default
        }
    }
}

extension Business.HTTPHeaders {
    func toAlamofireFriendly() -> Alamofire.HTTPHeaders {
        .init(map { key, value in
            HTTPHeader(name: key, value: value)
        })
    }
}
