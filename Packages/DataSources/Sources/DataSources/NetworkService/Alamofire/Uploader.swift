//
//  Uploader.swift
//  CAFU
//
//  Created by Ahmed Ramy on 12/09/2022.
//

import Alamofire
import Combine
import Configs
import Factory
import Foundation

// MARK: - Uploader

class Uploader {
    typealias Percentage = Double
    typealias Publisher<T> = AnyPublisher<Progress<T>, Error>
    private typealias Subject<T> = CurrentValueSubject<Progress<T>, Error>

    private let session: Session
    private var subjectsByTaskID = [UUID: Subject<Decodable>]()

    init(session: Session) {
        self.session = session
    }

    func upload<T: Decodable, U: Endpoint>(api: U, model: T.Type) -> ProgressResponse<T> {
        let subject: Subject<T> = Subject(.loading(0.0))
        var removeSubject: (() -> Void)?

        let task = session.upload(
            multipartFormData: { api.addParts(to: $0) },
            to: api.fullURL,
            usingThreshold: Container.shared.networkConfig().encodingMemoryThreshold)
            .uploadProgress(closure: { progress in
                subject.send(.loading(progress.fractionCompleted))
            })
            .responseDecodable(of: model, decoder: CAFUJSONDecoder()) { response in
                switch response.result {
                case .success(let model):
                    subject.send(.finished(model))
                    subject.send(completion: .finished)
                case .failure(let error):
                    subject.send(completion: .failure(error.asNetworkError()))
                }

                removeSubject?()
            }

        subjectsByTaskID[task.id] = subject as? Subject<Decodable>

        removeSubject = { [weak self] in
            self?.subjectsByTaskID.removeValue(forKey: task.id)
        }

        task.resume()

        return subject.eraseToAnyPublisher()
    }
}
