////
////  NetworkService.swift
////  The One (iOS)
////
////  Created by Ahmed Ramy on 21/10/2021.
////
//
//import Combine
//import Foundation
//import Moya
//import Alamofire
//import Pulse
//
//private final class NetworkProvider<Target> where Target: Moya.TargetType {
//    private let provider: MoyaProvider<Target>
//
//    init(
//        endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
//        requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
//        stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
//        plugins: [PluginType] = [],
//        trackInflights: Bool = false
//    ) {
//        
//        provider = MoyaProvider(
//            endpointClosure: endpointClosure,
//            requestClosure: requestClosure,
//            stubClosure: stubClosure,
//            session: {
//                let logger: NetworkLogger = NetworkLogger()
//                let eventMonitors: [EventMonitor] = [NetworkLoggerEventMonitor(logger: logger)]
//                return Alamofire.Session(eventMonitors: eventMonitors)
//            }(),
//            plugins: plugins,
//            trackInflights: trackInflights
//        )
//    }
//
//    func requestPublisher<T: Codable>(_ target: Target) -> AnyPublisher<T, Error> {
//        Deferred {
//            Future { promise in
//                // Execute Request from Moya
//                self.provider.request(target) { results in
//                    switch results {
//                    case let .success(response):
//                        // Check if response is successful or backend is failure status with custom errors
//                        if response.isSuccess {
//                            do {
//                                // Parse Data to expected model
//                                let response = try JSONDecoder().decode(T.self, from: response.data)
//                                promise(.success(response))
//                            } catch {
//                                // Parsing Error Occured
//                                LoggersManager.error("\(error)".tagWith([.internal, .parsing]))
//                                promise(.failure(.somethingWentWrong))
//                            }
//                        } else {
//                            // Backend returned a custom error response
//                            do {
//                                // Parse and map the error to SQError
//                                let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
//                                promise(.failure(errorResponse.errors?.first ?? .somethingWentWrong))
//                            } catch {
//                                // Parsing Error Occurred
//                                LoggersManager.error("\(error)".tagWith([.internal, .parsing]))
//                                promise(.failure(.somethingWentWrong))
//                            }
//                        }
//                    case let .failure(error):
//                        // Request failed for reasons out of the server handling, or the server didn't
//                        // return custom error
//                        LoggersManager.error("\(error)")
//                        promise(.failure(error.errorModels?.first ?? .somethingWentWrong))
//                    }
//                }
//            }
//        }.eraseToAnyPublisher()
//    }
//}
//
//extension Moya.Response {
//    var isSuccess: Bool {
//        (200 ... 299) ~= statusCode
//    }
//}
//
////  func request(_ token: Target) -> Observable<Moya.Response> {
////    return provider.rx.request(token).flatMap { (response) in
////      if response.statusCode == 401 {
////        return self.refreshSessionToken()
////          .do(onSuccess: { [weak self] token in
////            // Save token on expire here
////          }).flatMap { _ in
////            return self.request(token).asSingle()
////        }
////      } else {
////        return Single.just(response)
////      }
////      return Single.just(response)
////    }.asObservable().retryExponentially()
////  }
//
////  private func refreshSessionToken() -> Single<(String)> {
////    return Single.create { subscriber in
//// Example
////      let credentials = AuthenticationService.shared.loginCredentials
////      ServiceLocator.network.call(api: AuthEndpoint.login(credentials.email, credentials.password), model: LoginResponse.self, { (results) in
////        switch results {
////        case .success(let response):
////          switch response.status {
////          case 200:
////            subscriber(.success(response.data?.token ?? .empty))
////          default:
////            LoggersManager.error("Failed to Renew token")
////            subscriber(.error(LocalError.genericError))
////          }
////        case .failure(let error):
////          LoggersManager.error("Failed to Renew Token\nError: \(error)")
////          subscriber(.error(error))
////        }
////      })
////
////      return Disposables.create()
////    }
////  }
//
////public final class MoyaManager: NetworkProtocol {
////    var cancellables: Set<AnyCancellable> = []
////
////    private func reportErrors(_ error: Error) {
////        LoggersManager.error("\(error)")
////    }
////
////    public func call<T: Codable, U: BaseEndpoint>(api: U, model _: T.Type) -> AnyPublisher<T, Error> {
////        NetworkProvider<U>()
////            .requestPublisher(api)
////            .mapError { [weak self] error in
////                self?.reportErrors(error)
////                return error
////            }.eraseToAnyPublisher()
////    }
////
////    func removePreviousCall() {
////        cancellables.forEach { $0.cancel() }
////    }
////}
