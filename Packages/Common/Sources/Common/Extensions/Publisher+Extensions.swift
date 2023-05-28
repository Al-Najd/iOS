//
//  Publisher+Extensions.swift
//  CAFU
//
//  Created by Ahmed Ramy on 14/10/2022.
//

import Combine
import Configs
import UIKit

public extension Publisher where Self.Failure == Never {
    func uiSink(receiveValue: @escaping ((Output) -> Void)) -> AnyCancellable {
        receive(on: DispatchQueue.main).sink { output in
            receiveValue(output)
        }
    }

    /// Wraps sink block inside animation
    func animatedSink(receiveValue: @escaping ((Output) -> Void)) -> AnyCancellable {
        receive(on: DispatchQueue.main).sink { output in
            animate {
                receiveValue(output)
            }
        }
    }

    func transitionSink(
        receiveValue: @escaping ((Output) -> Void),
        with view: UIView,
        options: UIView.AnimationOptions = UIConfig.default.animationOptions,
        delay _: TimeInterval = 0)
        -> AnyCancellable {
        receive(on: DispatchQueue.main).sink { output in
            transition(with: view, options: options) {
                receiveValue(output)
            }
        }
    }

    private func animate(
        duration: TimeInterval = UIConfig.default.animationDuration,
        delay: TimeInterval = 0,
        options: UIView.AnimationOptions = UIConfig.default.animationOptions,
        animations: @escaping () -> Void,
        completion: ((UIViewAnimatingPosition) -> Void)? = nil) {
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: duration,
            delay: delay,
            options: options,
            animations: animations,
            completion: completion)
    }

    private func transition(
        with view: UIView,
        duration: TimeInterval = UIConfig.default.animationDuration,
        delay _: TimeInterval = 0,
        options: UIView.AnimationOptions = UIConfig.default.transitionOptions,
        animations: @escaping () -> Void,
        completion _: ((UIViewAnimatingPosition) -> Void)? = nil) {
        UIView.transition(with: view, duration: duration, options: options, animations: animations, completion: nil)
    }
}

public extension UILabel {
    func bind<T>(_ key: ReferenceWritableKeyPath<UILabel, T>, with publisher: AnyPublisher<T, Never>) -> Cancellable {
        publisher.uiSink { [weak self] value in
            guard let self = self else { return }
            self[keyPath: key] = value
        }
    }

    func bind<T>(_ key: ReferenceWritableKeyPath<UILabel, T>, with publisher: Published<T>.Publisher) -> Cancellable {
        publisher.uiSink { [weak self] value in
            guard let self = self else { return }
            self[keyPath: key] = value
        }
    }

    func bind<T>(_ key: ReferenceWritableKeyPath<UILabel, T?>, with publisher: Published<T>.Publisher) -> Cancellable {
        publisher.uiSink { [weak self] value in
            guard let self = self else { return }
            self[keyPath: key] = value
        }
    }

    func transitionBind<T>(_ key: ReferenceWritableKeyPath<UILabel, T>, with publisher: AnyPublisher<T, Never>) -> Cancellable {
        publisher.receive(on: DispatchQueue.main).transitionSink(receiveValue: { [weak self] value in
            guard let self = self else { return }
            self[keyPath: key] = value
        }, with: self)
    }

    func transitionBind<T>(_ key: ReferenceWritableKeyPath<UILabel, T>, with publisher: Published<T>.Publisher) -> Cancellable {
        publisher.receive(on: DispatchQueue.main).transitionSink(receiveValue: { [weak self] value in
            guard let self = self else { return }
            self[keyPath: key] = value
        }, with: self)
    }

    func transitionBind<T>(_ key: ReferenceWritableKeyPath<UILabel, T?>, with publisher: Published<T>.Publisher) -> Cancellable {
        publisher.receive(on: DispatchQueue.main).transitionSink(receiveValue: { [weak self] value in
            guard let self = self else { return }
            self[keyPath: key] = value
        }, with: self)
    }
}

public extension NSLayoutConstraint {
    func bind<T>(_ key: ReferenceWritableKeyPath<NSLayoutConstraint, T>, with publisher: AnyPublisher<T, Never>) -> Cancellable {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                self[keyPath: key] = value
            }
    }

    func bind<T>(_ key: ReferenceWritableKeyPath<NSLayoutConstraint, T>, with publisher: Published<T>.Publisher) -> Cancellable {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                self[keyPath: key] = value
            }
    }

    func bind<T>(_ key: ReferenceWritableKeyPath<NSLayoutConstraint, T?>, with publisher: Published<T>.Publisher) -> Cancellable {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                self[keyPath: key] = value
            }
    }
}

public extension UIView {
    func bind<T>(_ key: ReferenceWritableKeyPath<UIView, T>, with publisher: AnyPublisher<T, Never>) -> Cancellable {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                self[keyPath: key] = value
            }
    }

    func bind<T>(_ key: ReferenceWritableKeyPath<UIView, T>, with publisher: Published<T>.Publisher) -> Cancellable {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                self[keyPath: key] = value
            }
    }

    func bind<T>(_ key: ReferenceWritableKeyPath<UIView, T?>, with publisher: Published<T>.Publisher) -> Cancellable {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                self[keyPath: key] = value
            }
    }

    func transitionBind<T>(
        _ key: ReferenceWritableKeyPath<UIView, T>,
        with publisher: AnyPublisher<T, Never>)
        -> Cancellable {
        publisher.receive(on: DispatchQueue.main).transitionSink(receiveValue: { [weak self] in
            guard let self = self else { return }
            self[keyPath: key] = $0
        }, with: self)
    }

    func transitionBind<T>(
        _ key: ReferenceWritableKeyPath<UIView, T>,
        with publisher: Published<T>.Publisher)
        -> Cancellable {
        publisher.receive(on: DispatchQueue.main).transitionSink(receiveValue: { [weak self] in
            guard let self = self else { return }
            self[keyPath: key] = $0
        }, with: self)
    }

    func transitionBind<T>(
        _ key: ReferenceWritableKeyPath<UIView, T?>,
        with publisher: Published<T>.Publisher)
        -> Cancellable {
        publisher.receive(on: DispatchQueue.main).transitionSink(receiveValue: { [weak self] in
            guard let self = self else { return }
            self[keyPath: key] = $0
        }, with: self)
    }
}

public extension UIImageView {
    func bind<T>(_ key: ReferenceWritableKeyPath<UIImageView, T>, with publisher: AnyPublisher<T, Never>) -> Cancellable {
        publisher.uiSink { [weak self] value in
            guard let self = self else { return }
            self[keyPath: key] = value
        }
    }

    func bind<T>(_ key: ReferenceWritableKeyPath<UIImageView, T>, with publisher: Published<T>.Publisher) -> Cancellable {
        publisher.uiSink { [weak self] value in
            guard let self = self else { return }
            self[keyPath: key] = value
        }
    }

    func bind<T>(_ key: ReferenceWritableKeyPath<UIImageView, T?>, with publisher: Published<T>.Publisher) -> Cancellable {
        publisher.uiSink { [weak self] value in
            guard let self = self else { return }
            self[keyPath: key] = value
        }
    }

    func transitionBind<T>(
        _ key: ReferenceWritableKeyPath<UIImageView, T>,
        with publisher: AnyPublisher<T, Never>)
        -> Cancellable {
        publisher.receive(on: DispatchQueue.main).transitionSink(receiveValue: { [weak self] in
            guard let self = self else { return }
            self[keyPath: key] = $0
        }, with: self)
    }

    func transitionBind<T>(
        _ key: ReferenceWritableKeyPath<UIImageView, T>,
        with publisher: Published<T>.Publisher)
        -> Cancellable {
        publisher.receive(on: DispatchQueue.main).transitionSink(receiveValue: { [weak self] in
            guard let self = self else { return }
            self[keyPath: key] = $0
        }, with: self)
    }

    func transitionBind<T>(
        _ key: ReferenceWritableKeyPath<UIImageView, T?>,
        with publisher: Published<T>.Publisher)
        -> Cancellable {
        publisher.receive(on: DispatchQueue.main).transitionSink(receiveValue: { [weak self] in
            guard let self = self else { return }
            self[keyPath: key] = $0
        }, with: self)
    }
}
