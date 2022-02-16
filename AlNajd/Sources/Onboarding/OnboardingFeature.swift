//
//  File 2.swift
//  
//
//  Created by Ahmed Ramy on 16/02/2022.
//

import ComposableArchitecture
import Business
import Common

// MARK: - State
public struct OnboardingState: Equatable {
  public var step: Step = .step0_InMemoryOfOurLovedOnes
  public var presentationStyle: PresentationStyle = .firstLaunch
  
  public init() { }
}

// MARK: - Step
public extension OnboardingState {
  enum Step: Int, CaseIterable, Comparable, Equatable, Codable, Identifiable {
    case step0_InMemoryOfOurLovedOnes
    case step00_ThisWorkIsSadaqaForAllOfUs
    case step1_Wakeup
    case step2_YouDontRemember
    case step3_YouAreBetterThanThis
    case step4_DoNotListenToHimHeIsNotYourFriend
    case step5_TryToRememberYourSelf
    case step6_WakeupMuslim
    case step7_RememberAllah
    case step8_RememberWhoYouAreAndWhereYouBelong
    case step9_RememberHowYouGetThere
    case step10_KnowYourWeapons
    case step11_TheRoadIsLongAndUnforgiving
    case step12_YouMustBecomeAMuslim
    case step13_Rise
    
    public var id: Int {
      self.rawValue
    }
    
    mutating func next() {
      self = Self(rawValue: self.rawValue + 1) ?? Self.allCases.last!
    }
    
    mutating func previous() {
      self = Self(rawValue: self.rawValue - 1) ?? Self.allCases.first!
    }
    
    public static func < (lhs: OnboardingState.Step, rhs: OnboardingState.Step) -> Bool {
      lhs.rawValue < rhs.rawValue
    }
  }
}

// MARK: - Presentation Style
public extension OnboardingState {
  enum PresentationStyle {
    case firstLaunch
  }
}

// MARK: - Action
public enum OnboardingAction: Equatable {
  case onAppear
  case delegate(DelegateAction)
  case nextStep
  case delayedNextStep
  case previousStep
  case getStarted
}

public extension OnboardingAction {
  enum DelegateAction {
    case getStarted
  }
}

// MARK: - Environment
public struct OnboardingEnvironment { public init() { } }

// MARK: - Reducer
public let onboardingReducer = Reducer<
  OnboardingState,
  OnboardingAction,
  CoreEnvironment<OnboardingEnvironment>
> { state, action, env in
  switch action {
    case .onAppear:
      state.step = env.cache().fetch(OnboardingState.Step.self, for: .onboardingStep) ?? .step0_InMemoryOfOurLovedOnes
      
      return state.step == OnboardingState.Step.allCases[0]
      ? Effect(value: .delayedNextStep)
        .delay(for: 4, scheduler: env.mainQueue.animation())
        .eraseToEffect()
        .cancellable(id: DelayedNextStepId())
      : .none
    case .nextStep, .delayedNextStep:
      state.step.next()
      return env
        .cache()
        .asyncSave(state.step, for: .onboardingStep)
        .fireAndForget()
    case .previousStep:
      state.step.previous()
    case .delegate(.getStarted):
      return .merge(
        env
          .cache()
          .asyncSave(true, for: .didCompleteOnboarding)
          .fireAndForget(),
        .cancel(id: DelayedNextStepId())
      )
    case .getStarted:
      return .init(value: .delegate(.getStarted))
  }
  
  return .none
}

extension CacheManager {
  public func asyncSave<T: Codable>(_ value: T, for key: StorageKey) -> Effect<Never, Never> {
    .fireAndForget { [weak self] in
      self?.save(value, for: key)
    }
  }
}

private struct DelayedNextStepId: Hashable {}
